let currentStep = 0;
const totalSteps = 14;
const STORAGE_KEY = 'abstractingEnemies_currentStep';

// Map step indices to actual filenames
const stepFiles = [
    'step0', 'step1', 'step2', 'step3', 'step4', 'step5', 'step6', 'step7',
    'step7b', 'step7c', 'step7d', 'step8', 'step8b', 'step9', 'step10'
];

// Initialize step dots
function initStepDots() {
    const dotsContainer = document.getElementById('stepDots');
    for (let i = 0; i <= totalSteps; i++) {
        const dot = document.createElement('div');
        dot.className = 'dot';
        if (i === 0) dot.classList.add('active');
        dot.addEventListener('click', () => goToStep(i));
        dotsContainer.appendChild(dot);
    }
}

// Load step content dynamically
async function loadStep(stepNum) {
    try {
        const stepFile = stepFiles[stepNum];
        const response = await fetch(`steps/${stepFile}.html`);
        if (!response.ok) throw new Error('Step not found');
        const content = await response.text();
        document.getElementById('step-content').innerHTML = content;
    } catch (error) {
        document.getElementById('step-content').innerHTML =
            `<p style="color: red;">Error loading step: ${error.message}</p>`;
    }
}

// Update the display
function updateDisplay() {
    // Load step content
    loadStep(currentStep);

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

    // Save progress to localStorage
    saveProgress();
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

function goToStep(stepNum) {
    if (stepNum >= 0 && stepNum <= totalSteps) {
        currentStep = stepNum;
        updateDisplay();
    }
}

// Save current progress to localStorage
function saveProgress() {
    localStorage.setItem(STORAGE_KEY, currentStep);
}

// Load saved progress from localStorage
function loadProgress() {
    const savedStep = localStorage.getItem(STORAGE_KEY);
    if (savedStep !== null) {
        const step = parseInt(savedStep, 10);
        if (step >= 0 && step <= totalSteps) {
            currentStep = step;
        }
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
    loadProgress();  // Load saved progress first
    initStepDots();
    updateDisplay();
});
