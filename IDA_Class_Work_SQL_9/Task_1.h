#pragma once
#include <vector>
#include <string>

#include "Service functions.h"

class Class_A
{
//private:
	int _A1;
	double _A2;
	std::string _A3_str;
	std::vector<Class_A*> _A4_vector_ptr;
	Class_A* _Class_A_ptr = nullptr;
public:
	Class_A(int A1,	double A2,	std::string A3);
	Class_A() {};
};

