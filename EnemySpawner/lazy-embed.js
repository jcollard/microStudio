/**
 * Lazy Embed - Creates iframe embeds with "Click to Play" overlay
 *
 * This script provides lazy-loading functionality for iframe embeds,
 * improving page load performance by only loading iframes when users
 * explicitly click to interact with them.
 */

/**
 * Creates a lazy-loaded iframe embed with "Click to Play" overlay
 * @param {string} containerId - ID of the container element
 * @param {string} embedUrl - URL to load in the iframe
 * @param {number} height - Height of the iframe in pixels (default: 400)
 */
function createLazyEmbed(containerId, embedUrl, height = 400) {
  const container = document.getElementById(containerId);
  if (!container) {
    console.error(`Container with ID "${containerId}" not found`);
    return;
  }

  // Create placeholder overlay
  const placeholder = document.createElement('div');
  placeholder.style.cssText = `
    position: relative;
    width: 100%;
    height: ${height}px;
    background: #1e1e1e;
    border: 2px solid #3a3a4a;
    border-radius: 6px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: background 0.2s ease, border-color 0.2s ease;
  `;

  placeholder.innerHTML = `
    <svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="40" cy="40" r="38" stroke="#5b9bd5" stroke-width="3" fill="#252535"/>
      <path d="M32 25 L32 55 L56 40 Z" fill="#5b9bd5"/>
    </svg>
    <div style="margin-top: 20px; color: #e0e0e0; font-size: 18px; font-weight: 500;">
      Click to Play
    </div>
    <div style="margin-top: 8px; color: #a0a0a0; font-size: 14px;">
      Demo will load when you click
    </div>
  `;

  // Hover effect
  placeholder.addEventListener('mouseenter', () => {
    placeholder.style.background = '#252535';
    placeholder.style.borderColor = '#5b9bd5';
  });

  placeholder.addEventListener('mouseleave', () => {
    placeholder.style.background = '#1e1e1e';
    placeholder.style.borderColor = '#3a3a4a';
  });

  // Click to load iframe
  placeholder.addEventListener('click', () => {
    const iframe = document.createElement('iframe');
    iframe.src = embedUrl;
    iframe.width = '100%';
    iframe.height = height;
    iframe.style.cssText = `
      border: 2px solid #3a3a4a;
      border-radius: 6px;
      background: #2d2d3d;
    `;

    // Replace placeholder with iframe
    container.innerHTML = '';
    container.appendChild(iframe);
  });

  container.appendChild(placeholder);
}
