<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classic Snake Game</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #2c3e50; /* Dark blue-grey background */
            margin: 0;
            font-family: 'Press Start 2P', cursive; /* A pixel-art font, will use a fallback if not available */
            color: #ecf0f1; /* Light text color */
            flex-direction: column;
        }

        /* Fallback font for the game if 'Press Start 2P' isn't loaded */
        @font-face {
            font-family: 'Press Start 2P';
            src: url('https://fonts.gstatic.com/s/pressstart2p/v15/8ReLzK3YaKn--JbP_c9ht5s.woff2') format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }

        #game-container {
            background-color: #34495e; /* Slightly lighter dark blue-grey for container */
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            padding: 20px;
            text-align: center;
        }

        canvas {
            background-color: #1a242f; /* Even darker background for the game board */
            border: 2px solid #555;
            display: block; /* Remove extra space below canvas */
            margin: 0 auto;
        }

        #score-board {
            margin-top: 15px;
            font-size: 1.2em;
            color: #ecf0f1;
            display: flex;
            justify-content: space-between;
            padding: 0 10px;
        }

        button {
            background-color: #27ae60; /* Green for start button */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2ecc71; /* Lighter green on hover */
        }

        #game-over-screen {
            display: none; /* Hidden by default */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            font-size: 1.5em;
            z-index: 10;
        }

        #game-over-screen h3 {
            margin-top: 0;
            color: #e74c3c; /* Red for Game Over text */
        }

        #final-score {
            font-size: 1.8em;
            margin: 15px 0;
            color: #f1c40f; /* Yellow for final score */
        }

        #restart-button {
            background-color: #e74c3c; /* Red for restart button */
            margin-top: 20px;
        }

        #restart-button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div id="game-container">
        <h1>SNAKE</h1>
        <div id="score-board">
            <span>Score: <span id="score">0</span></span>
            <span>High Score: <span id="highScore">0</span></span>
        </div>
        <canvas id="gameCanvas" width="400" height="400"></canvas>
        <button id="startButton">Start Game</button>
    </div>

    <div id="game-over-screen">
        <h3>GAME OVER!</h3>
        <p>Your Score: <span id="final-score">0</span></p>
        <button id="restart-button">Play Again</button>
    </div>

    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const scoreDisplay = document.getElementById('score');
        const highScoreDisplay = document.getElementById('highScore');
        const startButton = document.getElementById('startButton');
        const gameOverScreen = document.getElementById('game-over-screen');
        const finalScoreDisplay = document.getElementById('final-score');
        const restartButton = document.getElementById('restart-button');

        const gridSize = 20; // Size of each segment (snake, food)
        const canvasSize = canvas.width; // 400
        let snake = [{ x: 10, y: 10 }]; // Initial snake position
        let food = {};
        let dx = 0; // Horizontal velocity
        let dy = 0; // Vertical velocity
        let score = 0;
        let highScore = localStorage.getItem('snakeHighScore') || 0;
        let gameInterval;
        let gameSpeed = 150; // Milliseconds per frame
        let isGameOver = false;

        highScoreDisplay.textContent = highScore;

        function generateFood() {
            food = {
                x: Math.floor(Math.random() * (canvasSize / gridSize)),
                y: Math.floor(Math.random() * (canvasSize / gridSize))
            };
        }

        function drawRect(x, y, color) {
            ctx.fillStyle = color;
            ctx.fillRect(x * gridSize, y * gridSize, gridSize, gridSize);
            ctx.strokeStyle = '#2c3e50'; // Border for segments
            ctx.strokeRect(x * gridSize, y * gridSize, gridSize, gridSize);
        }

        function drawGame() {
            ctx.clearRect(0, 0, canvasSize, canvasSize); // Clear canvas

            // Draw food
            drawRect(food.x, food.y, '#e74c3c'); // Red food

            // Draw snake
            snake.forEach((segment, index) => {
                const color = (index === 0) ? '#2ecc71' : '#27ae60'; // Head is lighter green
                drawRect(segment.x, segment.y, color);
            });
        }

        function updateGame() {
            if (isGameOver) return;

            const head = { x: snake[0].x + dx, y: snake[0].y + dy };

            // Check for collision with walls
            if (
                head.x < 0 || head.x >= canvasSize / gridSize ||
                head.y < 0 || head.y >= canvasSize / gridSize
            ) {
                endGame();
                return;
            }

            // Check for collision with self
            for (let i = 1; i < snake.length; i++) {
                if (head.x === snake[i].x && head.y === snake[i].y) {
                    endGame();
                    return;
                }
            }

            snake.unshift(head); // Add new head

            // Check if snake ate food
            if (head.x === food.x && head.y === food.y) {
                score++;
                scoreDisplay.textContent = score;
                generateFood(); // Generate new food
                gameSpeed = Math.max(50, gameSpeed - 5); // Increase speed, minimum 50ms
                clearInterval(gameInterval);
                gameInterval = setInterval(updateGame, gameSpeed);
            } else {
                snake.pop(); // Remove tail if no food eaten
            }

            drawGame();
        }

        function changeDirection(event) {
            const keyPressed = event.keyCode;
            const LEFT = 37;
            const UP = 38;
            const RIGHT = 39;
            const DOWN = 40;

            // Prevent reversing direction
            const goingUp = dy === -1;
            const goingDown = dy === 1;
            const goingLeft = dx === -1;
            const goingRight = dx === 1;

            if (keyPressed === LEFT && !goingRight) {
                dx = -1;
                dy = 0;
            }
            if (keyPressed === UP && !goingDown) {
                dx = 0;
                dy = -1;
            }
            if (keyPressed === RIGHT && !goingLeft) {
                dx = 1;
                dy = 0;
            }
            if (keyPressed === DOWN && !goingUp) {
                dx = 0;
                dy = 1;
            }
        }

        function startGame() {
            isGameOver = false;
            snake = [{ x: 10, y: 10 }];
            food = {};
            dx = 1; // Start moving right
            dy = 0;
            score = 0;
            gameSpeed = 150; // Reset speed
            scoreDisplay.textContent = score;
            gameOverScreen.style.display = 'none';
            startButton.style.display = 'none'; // Hide start button once game starts
            restartButton.style.display = 'block'; // Show restart button

            generateFood();
            drawGame(); // Initial draw
            if (gameInterval) clearInterval(gameInterval); // Clear any existing interval
            gameInterval = setInterval(updateGame, gameSpeed);

            // Add event listener for key presses
            document.addEventListener('keydown', changeDirection);
        }

        function endGame() {
            isGameOver = true;
            clearInterval(gameInterval);
            document.removeEventListener('keydown', changeDirection); // Remove listener to prevent movement after game over

            // Update high score
            if (score > highScore) {
                highScore = score;
                localStorage.setItem('snakeHighScore', highScore);
                highScoreDisplay.textContent = highScore;
            }

            finalScoreDisplay.textContent = score;
            gameOverScreen.style.display = 'flex'; // Show game over screen
            startButton.style.display = 'none'; // Ensure start button stays hidden
        }

        // Event listeners for buttons
        startButton.addEventListener('click', startGame);
        restartButton.addEventListener('click', startGame); // Restart button uses the same start game logic

        // Initialize game with food and initial snake, but don't start movement until button click
        generateFood();
        drawGame();
    </script>
</body>
</html>
