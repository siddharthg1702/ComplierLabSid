#include<bits/stdc++.h>
using namespace std;

bool checkOperator(string s)
{
	string oper[] = {"+", "-", "=", "*", "%", "++", "--", "/", "||", "&&", ">", "<", ">=", "<=", "!=", "~", "=="};
	for(int i=0;i<17;i++)
	{
		if(s == oper[i])
		{
			return true;
		}
	}
	return false;
}

bool checkKeyword(string s)
{
	string arr[] = {"int", "float", "double", "char", "if", "else", "for", "while", "do", "return","else"};
	for(int i=0;i<11;i++)
	{
		if(s == arr[i])
		{
			return true;
		}
	}
	return false;
}

bool checkParanthesis(string s)
{
	for(int i=0; i<s.length(); i++)
	{
		if(s[i] == '(')
		{
			return true;
		}		
	}
	return false;
}

bool checkID(char s)
{
	if((s >= 'a' && s <= 'z') || (s >= 'A' && s <= 'Z') || s == '_')
	{
		return true;
	}
	else if(s >= '0' && s <= '9')
	{
		return true;
	}
	return false;
}

bool find(string s, vector<string> v)
{
	for(int i=0;i<v.size();i++)
	{
		if(v[i] == s)
		{
			return true;
		}
	}
	return false;
}


int main()
{
	freopen("prog1.cpp","r",stdin);
	vector<string> keyword, identifier, oper;
	while(!cin.eof())
	{
		string s;
		cin>>s;	
		if(checkKeyword(s) && !find(s,keyword))
		{
			keyword.push_back(s);
		}
		else
		{
			string temp = "";
			/*if(s.length() == 1)
			{
				if(checkID(s[i]))
				{
					identifier.push_back(temp);
				}
			}*/
			
			
			if((s[0] >= 'a' && s[0] <= 'z') || (s[0] >= 'A' && s[0] <= 'Z') || s[0] == '_')
			{
				for(int i=0; i<s.length(); i++)
				{
					if(checkID(s[i]))
					{
						temp += s[i];
					}
					else
					{
						if(temp.length()!= 0 && !find(temp,identifier))
						{
							if(checkKeyword(s) && !find(s,keyword))
							{
								keyword.push_back(s);
							}
							else if((temp[0] >= 'a' && temp[0] <= 'z') || (temp[0] >= 'A' && temp[0] <= 'Z') || temp[0] == '_')	
								identifier.push_back(temp);
						}
						temp = "";
						temp += s[i];
						if(i+1< s.length() && !checkID(s[i+1]))
						{
							string temp2 = temp;
							temp += s[i+1];
							if(checkOperator(temp))
							{
								i++;
								if(!find(temp,oper))
									oper.push_back(temp);
							}
							else
							{
								if(!find(temp2,oper))
									oper.push_back(temp2);
							}
						}
						else
						{
							if(!find(temp,oper))
								oper.push_back(temp);
						}
						temp = "";
					}
				}
				if(temp.length()!= 0 && !find(temp,identifier))
				{
					if(checkKeyword(s) && !find(s,keyword))
					{
						keyword.push_back(s);
					}
					else if((temp[0] >= 'a' && temp[0] <= 'z') || (temp[0] >= 'A' && temp[0] <= 'Z') || temp[0] == '_')
						identifier.push_back(temp);		
				}
			}
			else if(checkOperator(s))
			{
				if(!find(s,oper))
					oper.push_back(s);	
			}
			 	
		}
		
		/*if((s[0] >= 'a' && s[0] <= 'z') || (s[0] >= 'A' && s[0] <= 'Z') || s[0] == '_')
		{			
			if(checkKeyword(s))
			{
				keyword.push_back(s);
			}
			else if
			else
			{
				if(s[s.length()-1] == ';')
				{
					identifier.push_back(s.substr(0,s.length()-1));
				}
				else
				{
					identifier.push_back(s);
				}		
			}
		}
		else if(s[0] == '#')
		{
			punc.push_back(s.substr());
			keyword.push_back(s);
		}
		else if(checkOperator(s))
		{
			oper.push_back(s);
		}
		else if(s[0] == '\'')
		{
			if(s[s.length()-1] == ';')
			{
				cons.push_back(s.substr(0,s.length()-1));
			}
			else
			{
				cons.push_back(s);
			}
		}
		else if(s[0] >= '0' && s[0] <= '9')
		{
			if(s[s.length()-1] == ';')
			{
				cons.push_back(s.substr(0,s.length()-1));
			}
			else
			{
				cons.push_back(s);
			}			
		}
		else
		{
			punc.push_back(s);
		}	*/	
	}
	
	cout<<"Identifiers"<<endl;
	for(int i=0;i<identifier.size();i++)
	{
		cout<<identifier[i]<<endl;
	}
	cout<<endl;
	
	cout<<"Keywords"<<endl;
	for(int i=0;i<keyword.size();i++)
	{
		cout<<keyword[i]<<endl;
	}
	cout<<endl;
	
	cout<<"Operators"<<endl;
	for(int i=0;i<oper.size();i++)
	{
		cout<<oper[i]<<endl;
	}
	cout<<endl;
	
	/*cout<<"Constants"<<endl;
	for(int i=0;i<cons.size();i++)
	{
		cout<<cons[i]<<endl;
	}
	cout<<endl;
	
	cout<<"Punctuators"<<endl;
	for(int i=0;i<cons.size();i++)
	{
		cout<<punc[i]<<endl;
	}
	cout<<endl;*/
}
