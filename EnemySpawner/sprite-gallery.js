/**
 * Sprite Gallery System
 * Displays a modal with browseable sprite assets
 * Features: sprite grid, rotation controls, download functionality, category navigation
 */

// Sprite categories organized by directory
const SPRITE_CATEGORIES = {
    'Enemy Ships': [
        'Enemies/enemyBlack1.png',
        'Enemies/enemyBlack2.png',
        'Enemies/enemyBlack3.png',
        'Enemies/enemyBlack4.png',
        'Enemies/enemyBlack5.png',
        'Enemies/enemyBlue1.png',
        'Enemies/enemyBlue2.png',
        'Enemies/enemyBlue3.png',
        'Enemies/enemyBlue4.png',
        'Enemies/enemyBlue5.png',
        'Enemies/enemyGreen1.png',
        'Enemies/enemyGreen2.png',
        'Enemies/enemyGreen3.png',
        'Enemies/enemyGreen4.png',
        'Enemies/enemyGreen5.png',
        'Enemies/enemyRed1.png',
        'Enemies/enemyRed2.png',
        'Enemies/enemyRed3.png',
        'Enemies/enemyRed4.png',
        'Enemies/enemyRed5.png',
    ],
    'UFOs': [
        'ufoBlue.png',
        'ufoGreen.png',
        'ufoRed.png',
        'ufoYellow.png',
    ],
    'Player Ships': [
        'playerShip1_blue.png',
        'playerShip1_green.png',
        'playerShip1_orange.png',
        'playerShip1_red.png',
        'playerShip2_blue.png',
        'playerShip2_green.png',
        'playerShip2_orange.png',
        'playerShip2_red.png',
        'playerShip3_blue.png',
        'playerShip3_green.png',
        'playerShip3_orange.png',
        'playerShip3_red.png',
    ],
    'Lasers': [
        'Lasers/laserBlue01.png',
        'Lasers/laserBlue02.png',
        'Lasers/laserBlue03.png',
        'Lasers/laserBlue04.png',
        'Lasers/laserBlue05.png',
        'Lasers/laserBlue06.png',
        'Lasers/laserBlue07.png',
        'Lasers/laserBlue08.png',
        'Lasers/laserBlue09.png',
        'Lasers/laserBlue10.png',
        'Lasers/laserBlue11.png',
        'Lasers/laserBlue12.png',
        'Lasers/laserBlue13.png',
        'Lasers/laserBlue14.png',
        'Lasers/laserBlue15.png',
        'Lasers/laserBlue16.png',
        'Lasers/laserGreen01.png',
        'Lasers/laserGreen02.png',
        'Lasers/laserGreen03.png',
        'Lasers/laserGreen04.png',
        'Lasers/laserGreen05.png',
        'Lasers/laserGreen06.png',
        'Lasers/laserGreen07.png',
        'Lasers/laserGreen08.png',
        'Lasers/laserGreen09.png',
        'Lasers/laserGreen10.png',
        'Lasers/laserGreen11.png',
        'Lasers/laserGreen12.png',
        'Lasers/laserGreen13.png',
        'Lasers/laserGreen14.png',
        'Lasers/laserGreen15.png',
        'Lasers/laserGreen16.png',
        'Lasers/laserRed01.png',
        'Lasers/laserRed02.png',
        'Lasers/laserRed03.png',
        'Lasers/laserRed04.png',
        'Lasers/laserRed05.png',
        'Lasers/laserRed06.png',
        'Lasers/laserRed07.png',
        'Lasers/laserRed08.png',
        'Lasers/laserRed09.png',
        'Lasers/laserRed10.png',
        'Lasers/laserRed11.png',
        'Lasers/laserRed12.png',
        'Lasers/laserRed13.png',
        'Lasers/laserRed14.png',
        'Lasers/laserRed15.png',
        'Lasers/laserRed16.png',
    ],
    'Effects': [
        'Effects/fire00.png',
        'Effects/fire01.png',
        'Effects/fire02.png',
        'Effects/fire03.png',
        'Effects/fire04.png',
        'Effects/fire05.png',
        'Effects/fire06.png',
        'Effects/fire07.png',
        'Effects/fire08.png',
        'Effects/fire09.png',
        'Effects/fire10.png',
        'Effects/fire11.png',
        'Effects/fire12.png',
        'Effects/fire13.png',
        'Effects/fire14.png',
        'Effects/fire15.png',
        'Effects/fire16.png',
        'Effects/fire17.png',
        'Effects/fire18.png',
        'Effects/fire19.png',
        'Effects/shield1.png',
        'Effects/shield2.png',
        'Effects/shield3.png',
        'Effects/speed.png',
        'Effects/star1.png',
        'Effects/star2.png',
        'Effects/star3.png',
    ],
    'Damage': [
        'Damage/playerShip1_damage1.png',
        'Damage/playerShip1_damage2.png',
        'Damage/playerShip1_damage3.png',
        'Damage/playerShip2_damage1.png',
        'Damage/playerShip2_damage2.png',
        'Damage/playerShip2_damage3.png',
        'Damage/playerShip3_damage1.png',
        'Damage/playerShip3_damage2.png',
        'Damage/playerShip3_damage3.png',
    ],
    'Meteors': [
        'Meteors/meteorBrown_big1.png',
        'Meteors/meteorBrown_big2.png',
        'Meteors/meteorBrown_big3.png',
        'Meteors/meteorBrown_big4.png',
        'Meteors/meteorBrown_med1.png',
        'Meteors/meteorBrown_med3.png',
        'Meteors/meteorBrown_small1.png',
        'Meteors/meteorBrown_small2.png',
        'Meteors/meteorBrown_tiny1.png',
        'Meteors/meteorBrown_tiny2.png',
        'Meteors/meteorGrey_big1.png',
        'Meteors/meteorGrey_big2.png',
        'Meteors/meteorGrey_big3.png',
        'Meteors/meteorGrey_big4.png',
        'Meteors/meteorGrey_med1.png',
        'Meteors/meteorGrey_med2.png',
        'Meteors/meteorGrey_small1.png',
        'Meteors/meteorGrey_small2.png',
        'Meteors/meteorGrey_tiny1.png',
        'Meteors/meteorGrey_tiny2.png',
    ],
    'Parts': [
        'Parts/beam0.png',
        'Parts/beam1.png',
        'Parts/beam2.png',
        'Parts/beam3.png',
        'Parts/beam4.png',
        'Parts/beam5.png',
        'Parts/beam6.png',
        'Parts/beam7.png',
        'Parts/cockpitBlue_0.png',
        'Parts/cockpitBlue_1.png',
        'Parts/cockpitBlue_2.png',
        'Parts/cockpitBlue_3.png',
        'Parts/cockpitBlue_4.png',
        'Parts/cockpitBlue_5.png',
        'Parts/cockpitBlue_6.png',
        'Parts/cockpitGreen_0.png',
        'Parts/cockpitGreen_1.png',
        'Parts/cockpitGreen_2.png',
        'Parts/cockpitGreen_3.png',
        'Parts/cockpitGreen_4.png',
        'Parts/cockpitGreen_5.png',
        'Parts/cockpitGreen_6.png',
        'Parts/cockpitRed_0.png',
        'Parts/cockpitRed_1.png',
        'Parts/cockpitRed_2.png',
        'Parts/cockpitRed_3.png',
        'Parts/cockpitRed_4.png',
        'Parts/cockpitRed_5.png',
        'Parts/cockpitRed_6.png',
        'Parts/cockpitYellow_0.png',
        'Parts/cockpitYellow_1.png',
        'Parts/cockpitYellow_2.png',
        'Parts/cockpitYellow_3.png',
        'Parts/cockpitYellow_4.png',
        'Parts/cockpitYellow_5.png',
        'Parts/cockpitYellow_6.png',
        'Parts/engine0.png',
        'Parts/engine1.png',
        'Parts/engine2.png',
        'Parts/engine3.png',
        'Parts/engine4.png',
        'Parts/engine5.png',
        'Parts/gun00.png',
        'Parts/gun01.png',
        'Parts/gun02.png',
        'Parts/gun03.png',
        'Parts/gun04.png',
        'Parts/gun05.png',
        'Parts/gun06.png',
        'Parts/gun07.png',
        'Parts/gun08.png',
        'Parts/gun09.png',
        'Parts/gun10.png',
        'Parts/gun11.png',
        'Parts/gun12.png',
        'Parts/gun13.png',
        'Parts/scratch1.png',
        'Parts/scratch2.png',
        'Parts/scratch3.png',
        'Parts/turretBase_big.png',
        'Parts/turretBase_small.png',
        'Parts/turret_01_mk1.png',
        'Parts/turret_01_mk2.png',
        'Parts/turret_02_mk1.png',
        'Parts/turret_02_mk2.png',
        'Parts/turret_03_mk1.png',
        'Parts/turret_03_mk2.png',
        'Parts/turret_04_mk1.png',
        'Parts/turret_04_mk2.png',
        'Parts/turret_05_mk1.png',
        'Parts/turret_05_mk2.png',
        'Parts/turret_06_mk1.png',
        'Parts/turret_06_mk2.png',
        'Parts/wingBlue_0.png',
        'Parts/wingBlue_1.png',
        'Parts/wingBlue_2.png',
        'Parts/wingBlue_3.png',
        'Parts/wingBlue_4.png',
        'Parts/wingBlue_5.png',
        'Parts/wingBlue_6.png',
        'Parts/wingBlue_7.png',
        'Parts/wingGreen_0.png',
        'Parts/wingGreen_1.png',
        'Parts/wingGreen_2.png',
        'Parts/wingGreen_3.png',
        'Parts/wingGreen_4.png',
        'Parts/wingGreen_5.png',
        'Parts/wingGreen_6.png',
        'Parts/wingGreen_7.png',
        'Parts/wingRed_0.png',
        'Parts/wingRed_1.png',
        'Parts/wingRed_2.png',
        'Parts/wingRed_3.png',
        'Parts/wingRed_4.png',
        'Parts/wingRed_5.png',
        'Parts/wingRed_6.png',
        'Parts/wingRed_7.png',
        'Parts/wingYellow_0.png',
        'Parts/wingYellow_1.png',
        'Parts/wingYellow_2.png',
        'Parts/wingYellow_3.png',
        'Parts/wingYellow_4.png',
        'Parts/wingYellow_5.png',
        'Parts/wingYellow_6.png',
        'Parts/wingYellow_7.png',
    ],
    'Power-ups': [
        'Power-ups/bolt_bronze.png',
        'Power-ups/bolt_gold.png',
        'Power-ups/bolt_silver.png',
        'Power-ups/pill_blue.png',
        'Power-ups/pill_green.png',
        'Power-ups/pill_red.png',
        'Power-ups/pill_yellow.png',
        'Power-ups/powerupBlue.png',
        'Power-ups/powerupBlue_bolt.png',
        'Power-ups/powerupBlue_shield.png',
        'Power-ups/powerupBlue_star.png',
        'Power-ups/powerupGreen.png',
        'Power-ups/powerupGreen_bolt.png',
        'Power-ups/powerupGreen_shield.png',
        'Power-ups/powerupGreen_star.png',
        'Power-ups/powerupRed.png',
        'Power-ups/powerupRed_bolt.png',
        'Power-ups/powerupRed_shield.png',
        'Power-ups/powerupRed_star.png',
        'Power-ups/powerupYellow.png',
        'Power-ups/powerupYellow_bolt.png',
        'Power-ups/powerupYellow_shield.png',
        'Power-ups/powerupYellow_star.png',
        'Power-ups/shield_bronze.png',
        'Power-ups/shield_gold.png',
        'Power-ups/shield_silver.png',
        'Power-ups/star_bronze.png',
        'Power-ups/star_gold.png',
        'Power-ups/star_silver.png',
        'Power-ups/things_bronze.png',
        'Power-ups/things_gold.png',
        'Power-ups/things_silver.png',
    ],
    'UI': [
        'UI/buttonBlue.png',
        'UI/buttonGreen.png',
        'UI/buttonRed.png',
        'UI/buttonYellow.png',
        'UI/cursor.png',
        'UI/numeral0.png',
        'UI/numeral1.png',
        'UI/numeral2.png',
        'UI/numeral3.png',
        'UI/numeral4.png',
        'UI/numeral5.png',
        'UI/numeral6.png',
        'UI/numeral7.png',
        'UI/numeral8.png',
        'UI/numeral9.png',
        'UI/numeralX.png',
        'UI/playerLife1_blue.png',
        'UI/playerLife1_green.png',
        'UI/playerLife1_orange.png',
        'UI/playerLife1_red.png',
        'UI/playerLife2_blue.png',
        'UI/playerLife2_green.png',
        'UI/playerLife2_orange.png',
        'UI/playerLife2_red.png',
        'UI/playerLife3_blue.png',
        'UI/playerLife3_green.png',
        'UI/playerLife3_orange.png',
        'UI/playerLife3_red.png',
    ],
};

// Track rotation state for each sprite
const spriteRotations = {};

// Track current category
let currentCategory = 'Enemy Ships';

// Pagination settings
let SPRITES_PER_PAGE = 12; // Will be calculated dynamically
const categoryPages = {}; // Track current page for each category

// Grid constants for calculation
const SPRITE_CARD_MIN_WIDTH = 150; // Matches CSS minmax(150px, 1fr)
const SPRITE_CARD_HEIGHT = 250; // Approximate height of a sprite card

/**
 * Calculate how many sprites can fit on the page based on available space
 */
function calculateSpritesPerPage() {
    const grid = document.getElementById('sprite-grid');
    if (!grid) return 12; // Default fallback

    // Get actual dimensions of the grid
    const gridWidth = grid.clientWidth;
    const gridHeight = grid.clientHeight;

    // Responsive adjustments based on screen size
    const screenWidth = window.innerWidth;
    let minCardWidth, cardHeight, gap, padding;

    if (screenWidth <= 480) {
        // Mobile: 2 columns, smaller cards
        minCardWidth = 100;
        cardHeight = 220;
        gap = 10;
        padding = 20; // 10px on each side
    } else if (screenWidth <= 768) {
        // Tablet: smaller cards
        minCardWidth = 120;
        cardHeight = 230;
        gap = 15;
        padding = 30; // 15px on each side
    } else {
        // Desktop: full size
        minCardWidth = SPRITE_CARD_MIN_WIDTH;
        cardHeight = SPRITE_CARD_HEIGHT;
        gap = 20;
        padding = 40; // 20px on each side
    }

    // Account for padding
    const usableWidth = gridWidth - padding;
    const usableHeight = gridHeight - padding;

    // Calculate number of columns
    const columns = Math.floor((usableWidth + gap) / (minCardWidth + gap));

    // Calculate number of rows that can fit
    const rows = Math.floor((usableHeight + gap) / (cardHeight + gap));

    // Calculate total sprites per page (minimum 4, maximum 24)
    const spritesPerPage = Math.max(4, Math.min(24, columns * rows));

    return spritesPerPage;
}

/**
 * Show the sprite gallery modal
 */
function showGallery() {
    // Check if modal already exists
    let modal = document.getElementById('sprite-gallery-modal');

    if (!modal) {
        // Create modal
        modal = createGalleryModal();
        document.body.appendChild(modal);
    }

    // Show modal
    modal.style.display = 'flex';

    // Reset rotations
    Object.keys(spriteRotations).forEach(key => {
        spriteRotations[key] = 0;
    });

    // Initialize pagination for all categories
    Object.keys(SPRITE_CATEGORIES).forEach(category => {
        if (!(category in categoryPages)) {
            categoryPages[category] = 0;
        }
    });

    // Calculate sprites per page after modal is visible
    setTimeout(() => {
        SPRITES_PER_PAGE = calculateSpritesPerPage();
        renderSpriteGrid();
    }, 50);
}

/**
 * Hide the sprite gallery modal
 */
function hideGallery() {
    const modal = document.getElementById('sprite-gallery-modal');
    if (modal) {
        modal.style.display = 'none';

        // Clean up resize listener
        if (modal._resizeHandler) {
            window.removeEventListener('resize', modal._resizeHandler);
        }
    }
}

/**
 * Create the modal structure
 */
function createGalleryModal() {
    const modal = document.createElement('div');
    modal.id = 'sprite-gallery-modal';
    modal.className = 'sprite-gallery-overlay';

    // Generate category tabs
    const categoryTabs = Object.keys(SPRITE_CATEGORIES).map(category => {
        const activeClass = category === currentCategory ? 'active' : '';
        return `<button class="category-tab ${activeClass}" onclick="switchCategory('${category}')">${category}</button>`;
    }).join('');

    modal.innerHTML = `
        <div class="sprite-gallery-container">
            <div class="sprite-gallery-header">
                <h2>Sprite Gallery</h2>
                <button class="sprite-gallery-close" onclick="hideGallery()">&times;</button>
            </div>
            <div class="category-tabs">
                ${categoryTabs}
            </div>
            <div id="sprite-grid" class="sprite-grid">
                <!-- Sprites will be rendered here -->
            </div>
            <div class="pagination-controls" id="pagination-controls">
                <!-- Pagination will be rendered here -->
            </div>
        </div>
    `;

    // Close on overlay click
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            hideGallery();
        }
    });

    // Add resize listener to recalculate pagination on window resize
    let resizeTimeout;
    const resizeHandler = () => {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(() => {
            const oldSpritesPerPage = SPRITES_PER_PAGE;
            SPRITES_PER_PAGE = calculateSpritesPerPage();

            // Only re-render if the sprites per page actually changed
            if (oldSpritesPerPage !== SPRITES_PER_PAGE) {
                // Reset to first page of current category when layout changes
                categoryPages[currentCategory] = 0;
                renderSpriteGrid();
            }
        }, 150);
    };

    window.addEventListener('resize', resizeHandler);

    // Store handler reference for cleanup
    modal._resizeHandler = resizeHandler;

    return modal;
}

/**
 * Switch to a different sprite category
 */
function switchCategory(category) {
    currentCategory = category;

    // Update tab active states
    updateCategoryTabs();

    // Re-render sprite grid
    renderSpriteGrid();
}

/**
 * Render the sprite grid for the current category
 */
function renderSpriteGrid() {
    const grid = document.getElementById('sprite-grid');
    if (!grid) return;

    grid.innerHTML = '';

    const sprites = SPRITE_CATEGORIES[currentCategory] || [];
    const currentPage = categoryPages[currentCategory] || 0;
    const totalPages = Math.ceil(sprites.length / SPRITES_PER_PAGE);

    // Calculate start and end indices for current page
    const startIndex = currentPage * SPRITES_PER_PAGE;
    const endIndex = Math.min(startIndex + SPRITES_PER_PAGE, sprites.length);

    // Render sprites for current page
    for (let i = startIndex; i < endIndex; i++) {
        const card = createSpriteCard(sprites[i]);
        grid.appendChild(card);
    }

    // Render pagination controls
    renderPaginationControls(currentPage, totalPages, sprites.length);
}

/**
 * Render pagination controls
 */
function renderPaginationControls(currentPage, totalPages, totalSprites) {
    const paginationDiv = document.getElementById('pagination-controls');
    if (!paginationDiv) return;

    // Always show pagination controls
    paginationDiv.style.display = 'flex';

    const startSprite = currentPage * SPRITES_PER_PAGE + 1;
    const endSprite = Math.min((currentPage + 1) * SPRITES_PER_PAGE, totalSprites);

    paginationDiv.innerHTML = `
        <button class="pagination-btn" onclick="changePage(-1)">
            ← Previous
        </button>
        <span class="pagination-info">
            ${startSprite}-${endSprite} of ${totalSprites} sprites (Page ${currentPage + 1} of ${totalPages})
        </span>
        <button class="pagination-btn" onclick="changePage(1)">
            Next →
        </button>
    `;
}

/**
 * Change page by offset (-1 for previous, +1 for next)
 * Switches categories when reaching the end/beginning of a category
 */
function changePage(offset) {
    const sprites = SPRITE_CATEGORIES[currentCategory] || [];
    const totalPages = Math.ceil(sprites.length / SPRITES_PER_PAGE);
    const currentPage = categoryPages[currentCategory] || 0;
    const newPage = currentPage + offset;

    // Check if we need to switch categories
    if (offset > 0 && newPage >= totalPages) {
        // Moving forward past the last page - go to next category
        const categories = Object.keys(SPRITE_CATEGORIES);
        const currentIndex = categories.indexOf(currentCategory);
        const nextIndex = (currentIndex + 1) % categories.length; // Wrap around
        const nextCategory = categories[nextIndex];

        // Switch to next category and go to first page
        currentCategory = nextCategory;
        categoryPages[currentCategory] = 0;

        // Update tab active states
        updateCategoryTabs();
        renderSpriteGrid();
    } else if (offset < 0 && newPage < 0) {
        // Moving backward past the first page - go to previous category
        const categories = Object.keys(SPRITE_CATEGORIES);
        const currentIndex = categories.indexOf(currentCategory);
        const prevIndex = (currentIndex - 1 + categories.length) % categories.length; // Wrap around
        const prevCategory = categories[prevIndex];

        // Switch to previous category and go to last page
        const prevSprites = SPRITE_CATEGORIES[prevCategory] || [];
        const prevTotalPages = Math.ceil(prevSprites.length / SPRITES_PER_PAGE);
        currentCategory = prevCategory;
        categoryPages[currentCategory] = Math.max(0, prevTotalPages - 1);

        // Update tab active states
        updateCategoryTabs();
        renderSpriteGrid();
    } else {
        // Normal page change within current category
        categoryPages[currentCategory] = newPage;
        renderSpriteGrid();
    }
}

/**
 * Update category tab active states
 */
function updateCategoryTabs() {
    const tabs = document.querySelectorAll('.category-tab');
    tabs.forEach(tab => {
        if (tab.textContent === currentCategory) {
            tab.classList.add('active');
        } else {
            tab.classList.remove('active');
        }
    });
}

/**
 * Create a sprite card element
 */
function createSpriteCard(filename) {
    const card = document.createElement('div');
    card.className = 'sprite-card';

    // Initialize rotation state
    if (!(filename in spriteRotations)) {
        spriteRotations[filename] = 0;
    }

    const spritePath = `kenney-sprites/${filename}`;
    const spriteNameWithoutExt = filename.replace('.png', '');

    // Create a safe ID by replacing slashes with dashes
    const safeId = spriteNameWithoutExt.replace(/\//g, '-');

    // Display name without directory path (just the filename)
    // Convert to lowercase to match microStudio's automatic conversion
    const displayName = spriteNameWithoutExt.includes('/')
        ? spriteNameWithoutExt.split('/').pop().toLowerCase()
        : spriteNameWithoutExt.toLowerCase();

    card.innerHTML = `
        <div class="sprite-preview">
            <img src="${spritePath}" alt="${filename}" class="sprite-image" id="sprite-${safeId}">
        </div>
        <div class="sprite-filename">${displayName}</div>
        <div class="sprite-controls">
            <div class="sprite-rotation-controls">
                <button class="sprite-rotate-btn" onclick="rotateSpriteLeft('${filename}')" title="Rotate 90° counter-clockwise">
                    &#x21BA;
                </button>
                <button class="sprite-rotate-btn" onclick="rotateSpriteRight('${filename}')" title="Rotate 90° clockwise">
                    &#x21BB;
                </button>
            </div>
            <button class="sprite-download-btn" onclick="downloadSprite('${filename}')" title="Download rotated sprite">
                Download
            </button>
        </div>
    `;

    return card;
}

/**
 * Rotate sprite 90° counter-clockwise
 */
function rotateSpriteLeft(filename) {
    spriteRotations[filename] = (spriteRotations[filename] - 90) % 360;
    updateSpriteRotation(filename);
}

/**
 * Rotate sprite 90° clockwise
 */
function rotateSpriteRight(filename) {
    spriteRotations[filename] = (spriteRotations[filename] + 90) % 360;
    updateSpriteRotation(filename);
}

/**
 * Update the visual rotation of a sprite
 */
function updateSpriteRotation(filename) {
    const spriteNameWithoutExt = filename.replace('.png', '');
    const safeId = spriteNameWithoutExt.replace(/\//g, '-');
    const img = document.getElementById(`sprite-${safeId}`);

    if (img) {
        const rotation = spriteRotations[filename];
        img.style.transform = `rotate(${rotation}deg)`;
    }
}

/**
 * Download a sprite (with rotation applied via canvas)
 */
function downloadSprite(filename) {
    const rotation = spriteRotations[filename];
    const spritePath = `kenney-sprites/${filename}`;

    // Load image
    const img = new Image();
    img.crossOrigin = 'anonymous'; // Handle CORS if needed

    img.onload = function() {
        // Create canvas
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');

        // Calculate canvas size based on rotation
        const radians = (rotation * Math.PI) / 180;
        const sin = Math.abs(Math.sin(radians));
        const cos = Math.abs(Math.cos(radians));

        const newWidth = img.width * cos + img.height * sin;
        const newHeight = img.width * sin + img.height * cos;

        canvas.width = newWidth;
        canvas.height = newHeight;

        // Translate to center, rotate, then draw
        ctx.translate(newWidth / 2, newHeight / 2);
        ctx.rotate(radians);
        ctx.drawImage(img, -img.width / 2, -img.height / 2);

        // Convert to data URL and download
        canvas.toBlob(function(blob) {
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');

            // Generate download filename (without directory path)
            const spriteNameWithoutExt = filename.replace('.png', '');
            const baseName = spriteNameWithoutExt.includes('/')
                ? spriteNameWithoutExt.split('/').pop()
                : spriteNameWithoutExt;
            const rotationSuffix = rotation !== 0 ? `_rot${rotation}` : '';
            a.download = `${baseName}${rotationSuffix}.png`;

            a.href = url;
            a.click();

            // Clean up
            URL.revokeObjectURL(url);
        }, 'image/png');
    };

    img.onerror = function() {
        alert(`Error loading sprite: ${filename}`);
    };

    img.src = spritePath;
}
