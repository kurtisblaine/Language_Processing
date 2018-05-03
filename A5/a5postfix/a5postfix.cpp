/*
C++ program that evaluated post fix expressions
*/

#include <iostream>
#include <stack>
#include <string>

using namespace std;

//function calls declaration
int PostFixEval(string expression);
int MathEval(char operation, int num1, int num2);
bool OperatorEval(char ch);
bool NumberEval(char ch);

int main(){

	string expression;

	//get character from user
	getline(cin,expression);
		
	int equals = PostFixEval(expression);

	//prints result
	cout<<equals<<"\n";
	
}//end main

int PostFixEval(string expression){

	stack<int> stack;
	
	for(int i = 0;i <  expression.length(); i++){
		//scan through user input and disregard whitespace
		if(expression[i] == ' ') continue;

		else if(OperatorEval(expression[i])){
			//if true then continue

			//pop the two numbers
			int num1 = stack.top(); 
			stack.pop();
			int num2 = stack.top();
			stack.pop();

			int equals = MathEval(expression[i], num1, num2);
			
			//push what the equation equals to the stack
			stack.push(equals);
		} 
		
		else if(NumberEval(expression[i])){
			
			int j = 0;
			while(i < expression.length() && NumberEval(expression[i])){
				//if a digit has more than one number
				//add a 0 to the right and times by 10
				j = (j * 10 ) + (expression[i] - '0');
				i++;
			}
		i--;
		//offset of i out of while loop

		stack.push(j);

		}//end else if
	}//end for

	//pop the outcome
	return stack.top();

}//end postfixeval

//evaluation if the character is a digit
bool NumberEval(char ch ){
	if(ch >= '0' && ch <= '9') return true;
	else return false;
}

//evaluation if the character is an operation
bool OperatorEval(char ch){
	if(ch == '+' || ch == '-' || ch == '*' || ch =='/') return true;
	else return false;
}

//does the actual mathematics
int MathEval(char operation, int num1, int num2){
	if(operation == '+') return num1 + num2;
	else if(operation == '-') return num1 - num2;
	else if(operation == '*') return num1 * num2;
	else if(operation == '/') return num1 / num2;
	else cout<<"Enter '+' '-' '*' or '/'\n";
	return 0;
}
