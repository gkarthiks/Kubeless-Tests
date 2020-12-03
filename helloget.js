module.exports = {
  foo: function (event, context) {
  	console.log('hello world!'+new Date());
    return 'hello world!';
  }
}