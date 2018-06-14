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
    list_endpoint = '/service/rest/beta/search/assets'
    delete_endpoint = '/service/rest/beta/assets'
    
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
        url = "%s%s?%s" % (args.baseurl, list_endpoint, params)
        list_response = requests.get(url, auth=authentication)
    
        if list_response.status_code != 200:
            print list_response.status_code, list_response.reason
            return
        
        data = list_response.json()
        if args.filter:
            assets_list.extend([elem for elem in data['items'] if args.filter in elem['path']])
        else:
            assets_list.extend(data['items'])
        
        continuation_token = data['continuationToken']
        next_page = continuation_token != None

    for asset in assets_list:
        delete_url = "%s%s/%s" % (args.baseurl, delete_endpoint, asset['id'])
        delete_response = requests.delete(delete_url, auth=authentication)
        print "%s -> %s %s" % (asset['path'], delete_response.status_code, delete_response.reason)
        
if __name__ == "__main__":
    run()
