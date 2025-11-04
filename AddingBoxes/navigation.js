let currentStep = 0;
const totalSteps = 10;

// Initialize step dots
function initStepDots() {
    const dotsContainer = document.getElementById('stepDots');
    dotsContainer.innerHTML = '';
    for (let i = 0; i <= totalSteps; i++) {
        const dot = document.createElement('div');
        dot.className = 'dot';
        if (i === 0) dot.classList.add('active');
        dot.setAttribute('data-step', i);
        dot.setAttribute('title', `Go to Step ${i}`);

        // Add click handler to jump to specific step
        dot.addEventListener('click', () => {
            currentStep = i;
            updateDisplay();
        });

        dotsContainer.appendChild(dot);
    }
}

// Copy code to clipboard
function copyCodeToClipboard(codeBlock) {
    const codeText = codeBlock.querySelector('pre').textContent;

    navigator.clipboard.writeText(codeText).then(() => {
        // Show success feedback
        const originalText = codeBlock.getAttribute('data-original-before') || codeBlock.style.getPropertyValue('--before-content') || '📋 Copy this code';
        codeBlock.style.setProperty('--before-content', '"✅ Copied!"');

        // Reset after 2 seconds
        setTimeout(() => {
            codeBlock.style.setProperty('--before-content', `"${originalText}"`);
        }, 2000);
    }).catch(err => {
        console.error('Failed to copy code:', err);
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = codeText;
        textArea.style.position = 'fixed';
        textArea.style.opacity = '0';
        document.body.appendChild(textArea);
        textArea.select();
        try {
            document.execCommand('copy');
            codeBlock.style.setProperty('--before-content', '"✅ Copied!"');
            setTimeout(() => {
                codeBlock.style.setProperty('--before-content', '"📋 Copy this code"');
            }, 2000);
        } catch (err) {
            console.error('Fallback copy failed:', err);
        }
        document.body.removeChild(textArea);
    });
}

// Initialize copy buttons for code blocks
function initCopyButtons() {
    const codeBlocks = document.querySelectorAll('.code-block');
    codeBlocks.forEach(block => {
        // Skip blocks with .no-copy or .no-badge class
        if (block.classList.contains('no-copy') || block.classList.contains('no-badge')) {
            return;
        }

        block.style.cursor = 'pointer';
        block.addEventListener('click', () => {
            copyCodeToClipboard(block);
        });
    });
}

// Load step content from external HTML file
async function loadStepContent(stepNumber) {
    const contentDiv = document.getElementById('step-content');

    try {
        const response = await fetch(`steps/step${stepNumber}.html`);
        if (!response.ok) {
            throw new Error(`Failed to load step ${stepNumber}`);
        }
        const html = await response.text();
        contentDiv.innerHTML = html;
        contentDiv.style.animation = 'none';
        setTimeout(() => {
            contentDiv.style.animation = 'fadeIn 0.5s ease';
            // Initialize copy buttons after content loads
            initCopyButtons();
        }, 10);
    } catch (error) {
        console.error('Error loading step:', error);
        contentDiv.innerHTML = `
            <div class="warning-box">
                <h3>⚠️ Error Loading Step</h3>
                <p>Could not load step ${stepNumber}. Please check that the file exists.</p>
            </div>
        `;
    }
}

// Update the display
function updateDisplay() {
    // Load the current step content
    loadStepContent(currentStep);

    // Update progress bar
    const progress = (currentStep / totalSteps) * 100;
    document.getElementById('progressFill').style.width = progress + '%';

    // Update step indicator
    document.getElementById('stepNumber').textContent = `Step ${currentStep}`;
    document.getElementById('totalSteps').textContent = totalSteps;

    // Update dots
    const dots = document.querySelectorAll('.dot');
    dots.forEach((dot, index) => {
        dot.classList.remove('active', 'completed');
        if (index < currentStep) {
            dot.classList.add('completed');
        } else if (index === currentStep) {
            dot.classList.add('active');
        }
    });

    // Update button states
    document.getElementById('prevBtn').disabled = currentStep === 0;

    const nextBtn = document.getElementById('nextBtn');
    if (currentStep === totalSteps) {
        nextBtn.textContent = '🎉 Finished!';
    } else {
        nextBtn.textContent = 'Next →';
    }

    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function nextStep() {
    if (currentStep < totalSteps) {
        currentStep++;
        updateDisplay();
    }
}

function previousStep() {
    if (currentStep > 0) {
        currentStep--;
        updateDisplay();
    }
}

// Keyboard navigation
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowRight' && currentStep < totalSteps) {
        nextStep();
    } else if (e.key === 'ArrowLeft' && currentStep > 0) {
        previousStep();
    }
});

// Initialize on page load
window.addEventListener('DOMContentLoaded', () => {
    initStepDots();
    updateDisplay();
});
