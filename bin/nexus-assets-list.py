#!/usr/bin/env python
# coding: utf-8

import argparse
import urllib
import requests

def run():
    parser = argparse.ArgumentParser()
    parser.add_argument('-u', '--username', nargs='?', help='username for basic authentication')
    parser.add_argument('-p', '--password', nargs='?', help='password for basic authentication')
    parser.add_argument('-H', '--baseurl', required=True, help='URL of Nexus instance')
    parser.add_argument('-r', '--reponame', required=True, help='name of the repository to list')
    parser.add_argument('-q', '--query', nargs='?', help='keyword to search')
    parser.add_argument('-f', '--filter', nargs='?', help='string to filter the result')
    
    args = parser.parse_args()
    
    authentication = None
    resource = '/service/rest/beta/search/assets'
    
    query_args = { 'repository': args.reponame }
    if args.query:
        query_args['q'] = args.query
    
    if args.username and args.password:
        authentication = (args.username, args.password)
    
    next_page = True
    continuation_token = None
    assets_list = []
    
    while next_page:
        if continuation_token:
            query_args['continuationToken'] = continuation_token
        
        params = urllib.urlencode(query_args)
        url = "%s%s?%s" % (args.baseurl, resource, params)
        response = requests.get(url, auth=authentication)
    
        if response.status_code != 200:
            print response.status_code, response.text
            return
        
        data = response.json()
        if args.filter:
            assets_list.extend([elem for elem in data['items'] if args.filter in elem['path']])
        else:
            assets_list.extend(data['items'])
        
        continuation_token = data['continuationToken']
        next_page = continuation_token != None

    for asset in assets_list:
        print asset['path']
        
if __name__ == "__main__":
    run()
