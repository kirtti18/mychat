# MyChat

Flutter Realtime chat application using firebase

## Getting Started

1. Clone the repo
2. Replace your register app name with "com.saswat.ourchat" all over the place
3. In firebase authentication activate the google sign in
4. Create a firestore with production settings. Modify the below rule.


rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}

4. Create an storage account.

