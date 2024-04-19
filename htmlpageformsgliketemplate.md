<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report</title>
    <style>
        .chat-container {
            width: 80%;
            margin: auto;
            border: 1px solid #ccc;
            border-radius: 10px;
            overflow: hidden;
        }
        .chat-message {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
        }
        .user-message, .bot-message {
            border-radius: 10px;
            margin: 5px 10px;
            padding: 10px;
            display: inline-block;
            max-width: 70%;
            word-wrap: break-word;
        }
        .user-message {
            text-align: right;
            background-color: #DCF8C6;
        }
        .bot-message {
            text-align: left;
            background-color: #FFFFFF;
        }
        .response-buttons {
            display: flex;
            align-items: center;
        }
        .response-buttons button {
            margin-left: 10px;
        }
    </style>
</head>
<body>

    <!-- Display initial message outside the loop -->
    <div class="chat-message">
        <div class="user-message">
            <!-- Display initial message with bid submission question -->
            <p>Hello Bidder</p>

        </div>
        <div class="bot-message">
            <!-- Add space for bot message if needed -->
        </div>
    </div>
    <div class="chat-container">
        {% for row in report %}
            <div class="chat-message">
                <div class="user-message">
                    <!-- Display auction, item, and rank information for each row -->
                    <p>Auction ID: {{ row[0] }}</p>
                    <p>Item ID: {{ row[1] }}</p>
                    <p>Bidder Rank: {{ row[3] }}</p>
                    <p>Do you want to submit a bid for 160 Rs. to L1</p>
                </div>
                <div class="bot-message">
                    <!-- Display bid submission message and buttons for each row -->
                    <div class="response-buttons">
                        <form action="/response" method="post">
                            <input type="hidden" name="auction_id" value="{{ row[0] }}">
                            <input type="hidden" name="item_id" value="{{ row[1] }}">
                            <input type="hidden" name="bid_amount" value="160">
                            <button type="submit" name="response" value="approve">Submit</button>

                        </form>
                    </div>
                </div>
            </div>
        {% endfor %}
    </div>
</body>
</html>
