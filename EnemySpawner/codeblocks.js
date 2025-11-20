/**
 * Code Block and Diff Rendering Functions
 * Requires: highlight.js, jsdiff
 */

/**
 * Renders a syntax-highlighted code block with a copy button
 * @param {string} elementId - The ID of the element to render into
 * @param {string} code - The code to display
 * @param {string} language - The language for syntax highlighting (default: 'lua')
 */
function renderCodeBlock(elementId, code, language = 'lua') {
  const element = document.getElementById(elementId);
  if (!element) {
    console.error(`Element with ID "${elementId}" not found`);
    return;
  }

  // Create the code block HTML
  const html = `
    <div class="code-block-wrapper">
      <div class="code-block-header">
        <button class="copy-btn" onclick="copyCode('${elementId}-code')">Copy Code</button>
      </div>
      <pre><code id="${elementId}-code" class="language-${language}">${escapeHtml(code)}</code></pre>
    </div>
  `;

  element.innerHTML = html;

  // Apply syntax highlighting
  const codeElement = document.getElementById(`${elementId}-code`);
  if (typeof hljs !== 'undefined') {
    hljs.highlightElement(codeElement);
  }
}

/**
 * Renders a side-by-side diff view with a copy button
 * @param {string} elementId - The ID of the element to render into
 * @param {string} oldCode - The original code (before)
 * @param {string} newCode - The modified code (after)
 * @param {string} description - Optional description of the changes
 */
function renderDiffBlock(elementId, oldCode, newCode, description = '') {
  const element = document.getElementById(elementId);
  if (!element) {
    console.error(`Element with ID "${elementId}" not found`);
    return;
  }

  // Check if Diff library is available
  if (typeof Diff === 'undefined') {
    console.error('jsdiff library not loaded');
    element.innerHTML = '<p style="color: red;">Error: jsdiff library not loaded</p>';
    return;
  }

  // Compute line-based diff
  const diff = Diff.diffLines(oldCode, newCode);

  // Build the diff HTML
  let leftLines = [];
  let rightLines = [];
  let leftLineNum = 1;
  let rightLineNum = 1;

  diff.forEach(part => {
    const lines = part.value.split('\n');
    // Remove last empty line if it exists
    if (lines[lines.length - 1] === '') {
      lines.pop();
    }

    if (part.removed) {
      // Lines only in old code (left side, red)
      lines.forEach(line => {
        leftLines.push({
          num: leftLineNum++,
          content: line,
          type: 'removed'
        });
        rightLines.push({
          num: '',
          content: '',
          type: 'empty'
        });
      });
    } else if (part.added) {
      // Lines only in new code (right side, green)
      lines.forEach(line => {
        leftLines.push({
          num: '',
          content: '',
          type: 'empty'
        });
        rightLines.push({
          num: rightLineNum++,
          content: line,
          type: 'added'
        });
      });
    } else {
      // Unchanged lines (both sides)
      lines.forEach(line => {
        leftLines.push({
          num: leftLineNum++,
          content: line,
          type: 'unchanged'
        });
        rightLines.push({
          num: rightLineNum++,
          content: line,
          type: 'unchanged'
        });
      });
    }
  });

  // Build HTML
  let leftHtml = '';
  let rightHtml = '';

  leftLines.forEach((line, idx) => {
    const lineClass = line.type === 'removed' ? 'diff-line-removed' :
                      line.type === 'empty' ? 'diff-line-empty' :
                      'diff-line-unchanged';
    const highlightedContent = highlightCode(line.content, 'lua');
    leftHtml += `
      <div class="${lineClass}">
        <span class="line-num">${line.num}</span>
        <span class="line-content">${highlightedContent}</span>
      </div>
    `;
  });

  rightLines.forEach((line, idx) => {
    const lineClass = line.type === 'added' ? 'diff-line-added' :
                      line.type === 'empty' ? 'diff-line-empty' :
                      'diff-line-unchanged';
    const highlightedContent = highlightCode(line.content, 'lua');
    rightHtml += `
      <div class="${lineClass}">
        <span class="line-num">${line.num}</span>
        <span class="line-content">${highlightedContent}</span>
      </div>
    `;
  });

  const html = `
    <div class="diff-block-wrapper">
      <div class="diff-header">
        <span class="diff-description">${escapeHtml(description)}</span>
        <button class="copy-btn" onclick="copyCode('${elementId}-new-code', true)">Copy Code</button>
      </div>
      <div class="diff-container">
        <div class="diff-side diff-left">
          <div class="diff-side-header">Before</div>
          <div class="diff-lines">
            ${leftHtml}
          </div>
        </div>
        <div class="diff-side diff-right">
          <div class="diff-side-header">After</div>
          <div class="diff-lines" id="${elementId}-new-code" data-code="${escapeHtml(newCode)}">
            ${rightHtml}
          </div>
        </div>
      </div>
    </div>
  `;

  element.innerHTML = html;
}

/**
 * Copies code to clipboard and shows feedback
 * @param {string} elementId - The ID of the code element to copy
 * @param {boolean} useDataAttribute - If true, copy from data-code attribute instead of text content
 */
function copyCode(elementId, useDataAttribute = false) {
  const element = document.getElementById(elementId);
  if (!element) {
    console.error(`Element with ID "${elementId}" not found`);
    return;
  }

  // Get the code text
  let code;
  if (useDataAttribute) {
    code = element.getAttribute('data-code');
  } else {
    code = element.textContent;
  }

  // Copy to clipboard
  navigator.clipboard.writeText(code).then(() => {
    // Find the copy button and show feedback
    const buttons = document.querySelectorAll('.copy-btn');
    buttons.forEach(btn => {
      if (btn.getAttribute('onclick').includes(elementId)) {
        const originalText = btn.textContent;
        btn.textContent = 'Copied!';
        btn.classList.add('copied');

        setTimeout(() => {
          btn.textContent = originalText;
          btn.classList.remove('copied');
        }, 2000);
      }
    });
  }).catch(err => {
    console.error('Failed to copy code:', err);
    alert('Failed to copy code to clipboard');
  });
}

/**
 * Escapes HTML special characters
 * @param {string} text - The text to escape
 * @returns {string} - Escaped text
 */
function escapeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

/**
 * Applies syntax highlighting to a single line of code
 * @param {string} code - The code to highlight
 * @param {string} language - The language for syntax highlighting
 * @returns {string} - Highlighted HTML
 */
function highlightCode(code, language = 'lua') {
  if (!code || code.trim() === '') {
    return escapeHtml(code);
  }

  if (typeof hljs !== 'undefined') {
    try {
      const result = hljs.highlight(code, { language: language, ignoreIllegals: true });
      return result.value;
    } catch (e) {
      // If highlighting fails, return escaped HTML
      return escapeHtml(code);
    }
  }

  // Fallback if highlight.js is not available
  return escapeHtml(code);
}
