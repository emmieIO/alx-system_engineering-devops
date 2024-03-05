#!/usr/bin/python3
"""A python function that queries the Reddit API and returns
the number of subscribers
(not active users, total subscribers)
for a given subreddit """
import requests


def number_of_subscribers(subreddit):
    """Return the total number of subscribers on a given subreddit."""
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {
        "User-Agent": "Python Reddit API Script by /user/emmieio"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        return data['data']['subscribers']
    else:
        return 0
