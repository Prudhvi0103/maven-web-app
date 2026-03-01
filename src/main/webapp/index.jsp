<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TECH EXPERT SOLUTION INDIA</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;

            /* Background image + overlay */
            background-image: 
                linear-gradient(rgba(245, 247, 250, 0.88), rgba(228, 233, 253, 0.92)),
                url('https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&q=80&w=2072');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background: rgba(255, 255, 255, 0.96);
            border-radius: 20px;
            box-shadow: 0 12px 50px rgba(0, 0, 0, 0.12);
            padding: 50px;
            max-width: 1000px;
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            gap: 50px;
            align-items: center;
            border: 1px solid rgba(224, 231, 255, 0.7);
            backdrop-filter: blur(8px);
        }

        .content {
            flex: 1;
            min-width: 300px;
            text-align: center;
        }

        .trainee-section {
            flex: 0 0 280px;
            text-align: center;
        }

        .trainee-img {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            object-fit: cover;
            border: 6px solid #006400;
            box-shadow: 0 8px 30px rgba(0, 100, 0, 0.25);
            margin-bottom: 15px;
        }

        .trainee-name {
            color: #006400;
            font-size: 1.5rem;
            font-weight: 700;
        }

        h1 {
            color: #006400;
            font-size: 2.6rem;
            margin-bottom: 1.6rem;
            font-weight: 700;
        }

        h2 {
            color: #2c3e50;
            font-size: 1.4rem;
            margin: 1.8rem 0 1rem;
            font-weight: 600;
        }

        .highlight-phone {
            color: #c62828;
            font-weight: 700;
            font-size: 1.5rem;
            margin: 1rem 0;
            letter-spacing: 0.6px;
        }

        .company-link {
            display: inline-block;
            margin: 2.2rem 0 1.8rem;
            padding: 16px 40px;
            background: #006400;
            color: white;
            text-decoration: none;
            font-size: 1.25rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.35s ease;
            box-shadow: 0 6px 20px rgba(0, 100, 0, 0.3);
        }

        .company-link:hover {
            background: #004d00;
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0, 100, 0, 0.4);
        }

        .tagline {
            color: #444;
            font-size: 1.2rem;
            margin-bottom: 2.2rem;
            max-width: 720px;
            margin-left: auto;
            margin-right: auto;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                padding: 40px 30px;
            }
            .trainee-section {
                margin-top: 30px;
            }
            h1 {
                font-size: 2.2rem;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="content">
            <h1>Welcome to TECH EXPERT SOLUTION INDIA</h1>
            
            <p class="tagline">
                Your career partner! One of India's best Training destinations for Software, Networking, and Cloud Computing courses with 18 years of Industrial experience.
            </p>

            <a href="https://scopeindia.org" class="company-link" target="_blank">
                Click Here to see more about our company →
            </a>

            <h2>Contact Us / WhatsApp</h2>
            <div class="highlight-phone">
                +91 91485 43822
            </div>
            <div class="highlight-phone">
                +91 62814 06619
            </div>
        </div>

        <div class="trainee-section">
            <img 
                src="https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=800" 
                alt="Trainee Jana" 
                class="trainee-img"
            >
            <div class="trainee-name">Jana</div>
        </div>
    </div>

</body>
</html>
