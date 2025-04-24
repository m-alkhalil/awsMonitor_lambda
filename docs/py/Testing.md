how testing works:

def test_lambda_start_success():
Arrange: prepare mocks and inputs
Act: call lambda_handler
Assert: check if EC2 was called and SNS message was sent

* mock boto3.clinet objects, ec2 and sns
* os.environ.get
* event payload

Then we’ll assert:
* ec2.start_instances() was called with the correct ID.
* sns.publish() was called with the expected message and subject.
* Correct return values and status codes.

@patch is a decorator provided by unittest.mock. It temporarily replaces (“mocks”) the actual object you specify with a fake (mocked) version just for the duration of the test.
It’s useful when you want to:
 *   Avoid making real API calls ( boto3.client).
*    Control what those calls return.
*    Track if and how they were used (called).

 What is .side_effect in unittest.mock?
.side_effect controls what happens when your mock is called. You can use it in 3 main ways:
* To change the return value dynamically:
```
mock.side_effect = lambda x: x * 2

mock(3)  # returns 6
mock(5)  # returns 10
```
* To raise exceptions when called
```
mock.side_effect = Exception("Boom!")

mock()  #>> will raise Exception: Boom!
```
* To return a sequence of values: Each call will return the next item.
```
mock.side_effect = [10, 20, 30]

mock()  # returns 10
mock()  # returns 20
mock()  # returns 30
```