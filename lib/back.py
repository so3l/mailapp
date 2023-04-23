#from __future__ import print_function
from flask import Flask, jsonify

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
import base64
from bs4 import BeautifulSoup

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

app=Flask(__name__)
@app.route("/", methods=["GET"])
def primary():
    """Shows basic usage of the Gmail API.
    Lists the user's Gmail labels.
    """
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    cwd=os.getcwd()
    cwd+=r'\lib'
    if os.path.exists(rf'{cwd}\token.json'):
        creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                rf'{cwd}\credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials  for the next run
        with open(rf'{cwd}\token.json', 'w') as token:
            token.write(creds.to_json())
    # try:
    #     # Call the Gmail API
    #     service = build('gmail', 'v1', credentials=creds)
    #     results = service.users().labels().list(userId='me').execute()
    #     labels = results.get('labels', [])

    #     if not labels:
    #         print('No labels found.')
    #         return
    #     print('Labels:')
    #     for label in labels:
    #         print(label['name'])

    # except HttpError as error:
    #     # TODO(developer) - Handle errors from gmail API.
    #     print(f'An error occurred: {error}')

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50)   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                try:
                    parts = payload.get('parts')[0]
                    data = parts['body']['data']
                    data = data.replace("-","+").replace("_","/")
                    decoded_data = base64.b64decode(data)
                except:
                    continue
      
                # Now, the data obtained is in lxml. So, we will parse 
                # it with BeautifulSoup library
                soup = BeautifulSoup(decoded_data , "lxml")
                body = soup.body().text()
                
                Subject.append(subject)
                Sender.append(sender)
                Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender})
    #i=0
    # try:
    #     for sub in Subject:
    #         print("Subject: ",sub)
    #         print("Sender: ",Sender[i])
    #         print("Body: ",Body[i])
    #         print("\n")
    #         i+=1
        
    # except Exception as er:
    #     print(f"An error has occured {er}")


@app.route("/spam",methods=['GET'])
def spam():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    cwd=os.getcwd()
    cwd+=r'\lib'
    if os.path.exists(rf'{cwd}\token.json'):
        creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                rf'{cwd}\credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials  for the next run
        with open(rf'{cwd}\token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["SPAM"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                try:
                    parts = payload.get('parts')[0]
                    data = parts['body']['data']
                    data = data.replace("-","+").replace("_","/")
                    decoded_data = base64.b64decode(data)
                except:
                    continue
      
                # Now, the data obtained is in lxml. So, we will parse 
                # it with BeautifulSoup library
                soup = BeautifulSoup(decoded_data , "lxml")
                body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender})

@app.route("/important",methods=['GET'])
def important():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    cwd=os.getcwd()
    cwd+=r'\lib'
    if os.path.exists(rf'{cwd}\token.json'):
        creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                rf'{cwd}\credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials  for the next run
        with open(rf'{cwd}\token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["IMPORTANT"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                try:
                    parts = payload.get('parts')[0]
                    data = parts['body']['data']
                    data = data.replace("-","+").replace("_","/")
                    decoded_data = base64.b64decode(data)
                except:
                    continue
      
                # Now, the data obtained is in lxml. So, we will parse 
                # it with BeautifulSoup library
                soup = BeautifulSoup(decoded_data , "lxml")
                body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender})

@app.route("/starred",methods=['GET'])
def starred():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    cwd=os.getcwd()
    cwd+=r'\lib'
    if os.path.exists(rf'{cwd}\token.json'):
        creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                rf'{cwd}\credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials  for the next run
        with open(rf'{cwd}\token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["STARRED"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return "404"
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                try:
                    parts = payload.get('parts')[0]
                    data = parts['body']['data']
                    data = data.replace("-","+").replace("_","/")
                    decoded_data = base64.b64decode(data)
                except:
                    continue
      
                # Now, the data obtained is in lxml. So, we will parse 
                # it with BeautifulSoup library
                soup = BeautifulSoup(decoded_data , "lxml")
                body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender})


if __name__ == '__main__':
    app.run(debug=True)
