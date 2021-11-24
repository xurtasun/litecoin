import requests

class Parser():
    def __init__(self, url = None):
        self.url = url
        self.comments = requests.get(self.url).json()

    def printValues(self, key):
        for comment in self.comments:
            print(comment[key])

if __name__ == '__main__':
    parser = Parser(
        url = 'https://jsonplaceholder.typicode.com/comments'
    )

    parser.printValues('id')
