package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {

    @GetMapping(value = "/hello", produces = "text/html;charset=UTF-8")
    @ResponseBody  // Return HTML content as the response body
    public String hello() {
        return """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hello Page</title>
                <style>
                    /* Full screen body setup */
                    body {
                        font-family: 'Arial', sans-serif;
                        background: linear-gradient(45deg, #6e7dff, #ff6b6b);
                        height: 100vh;
                        margin: 0;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        overflow: hidden;
                        animation: bgAnim 10s ease infinite;
                    }

                    /* Container style */
                    .container {
                        background-color: rgba(255, 255, 255, 0.9);
                        border-radius: 20px;
                        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                        padding: 50px;
                        text-align: center;
                        transform: scale(0.95);
                        animation: scaleUp 0.5s ease-out forwards;
                    }

                    /* Heading styling with animation */
                    h1 {
                        font-size: 3rem;
                        color: #333;
                        font-weight: 700;
                        margin: 0;
                        animation: bounce 2s infinite ease-in-out;
                    }

                    /* Animation for background color change */
                    @keyframes bgAnim {
                        0% { background: linear-gradient(45deg, #6e7dff, #ff6b6b); }
                        50% { background: linear-gradient(45deg, #ff6b6b, #6e7dff); }
                        100% { background: linear-gradient(45deg, #6e7dff, #ff6b6b); }
                    }

                    /* Animation for scaling up container */
                    @keyframes scaleUp {
                        0% { transform: scale(0.95); }
                        100% { transform: scale(1); }
                    }

                    /* Animation for bouncing heading */
                    @keyframes bounce {
                        0%, 100% { transform: translateY(0); }
                        50% { transform: translateY(-20px); }
                    }

                    /* Hover effect for container */
                    .container:hover {
                        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
                        transform: translateY(-10px);
                        transition: all 0.3s ease;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Welcome to TrueOps!</h1>
                </div>
            </body>
            </html>
        """;
    }
}
