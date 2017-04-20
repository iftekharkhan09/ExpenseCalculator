package com.src.controller;


class X
{
	public String mark()
	{
		return "X";
	}
}
class Y extends X
{
	public String mark()
{
	return "Y";
}	
}
class Z extends Y
{	
public String mark()
{
	return "X";
}
}
class A extends Z
{	
}

public class hel {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		System.out.println(new A().mark());
		
	}

}

