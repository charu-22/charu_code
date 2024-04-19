from flask import Flask, request, render_template
import psycopg2

app = Flask(__name__)

# Database connection details

# Database connection
dbname = ''
user = ''
password = ''
host = ''  # Usually 'localhost' if the database is hosted locally

conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host)

def fetch_userid(login_id):
    # Connect to the database
    cur = conn.cursor()

    # Execute the query to fetch userid based on loginid
    cur.execute("SELECT userid FROM appuser.tbl_userlogin WHERE loginid LIKE %s", (login_id,))
    row = cur.fetchone()
    if row:
        userid = row[0]  # Fetch the first row and first column value
    else:
        # Handle case when no userid is found for the given loginid
        # For example, you can return None or raise an exception
        raise ValueError("No userid found for loginid: " + login_id)

    # Return cursor and userid
    return cur, userid

def fetch_report(auction_id, userid):
    # Connect to the database
    cur = conn.cursor()

    # Fetch the login ID associated with the userid
    cur.execute("SELECT columnname FROM tablename WHERE othercolumn = %s", (otehrcolumn,))
    login_id = cur.fetchone()[0]

    # Execute the provided SQL query
    query = """
    SELECT 
        b.parentid AS auctionid,
        b.rowid AS itemid,
        %s as loginid,
        (SELECT bidderrank 
         FROM appauctionbid.tbl_auctionbidRank 
         WHERE auctionid = b.parentid 
               AND bidderid = b.bidderid 
               AND rowid = b.rowid) AS bidderrank
    FROM 
        appcommon.tbl_itembiddermapping b
    WHERE 
        b.parentid = %s 
        AND b.bidderid = %s
        AND b.isactive = 1
    """
    cur.execute(query, (login_id, auction_id, userid))
    report = cur.fetchall()

    # Close the cursor (no need to close the connection here)
    cur.close()

    return report

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        auction_id = request.form['auction_id']
        login_id = request.form['login_id']
        
        # Fetch userid based on login ID
        cur, userid = fetch_userid(login_id)
        
        # Fetch report based on auction ID and userid
        report = fetch_report(auction_id, userid)

        # Close the cursor
        cur.close()

        return render_template('report_msg.html', report=report)
    
    return render_template('bid.html')

if __name__ == '__main__':
    app.run(debug=True, host='192.168.100.217')
