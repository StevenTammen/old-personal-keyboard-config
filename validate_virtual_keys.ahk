#NoEnv
SendMode Input
#SingleInstance force

/*
List of unassigned keys, according to
https://autohotkey.com/board/topic/98757-how-to-create-a-new-virtual-keys/

VK07
VK0E
VK0F
VK16
VK1A
VK3A
VK3B
VK3C
VK3D
VK3E
VK3F
VK40
VK88
VK89
VK8A
VK8B
VK8C
VK8D
VK8E
VK8F
VK97
VK98
VK99
VK9A
VK9B
VKD8
VKD9
VKDA
VKE8

You should try them on your system to make sure there are no unintended 
side-effects. With this script active, simply press a-z and 1-3 in 
several different applications(including a terminal), and see if anything 
happens.

For me, the following keys had some behavior associated with them:

VK07, VK9A, VK9B, VKD8, VKD9, VKDA

This means that the keys I can use, in order of hex code (and therefore priority
when using the Dual library) are the following:

VK0E
VK0F
VK16
VK1A
VK3A
VK3B
VK3C
VK3D
VK3E
VK3F
VK40
VK88
VK89
VK8A
VK8B
VK8C
VK8D
VK8E
VK8F
VK97
VK98
VK99
VKE8
*/



*q::
	SendInput {VK07}
	return
*w::
	SendInput {VK0E}
	return
*e::
	SendInput {VK0F}
	return
*r::
	SendInput {VK16}
	return
*t::
	SendInput {VK1A}
	return
*y::
	SendInput {VK3A}
	return
*u::
	SendInput {VK3B}
	return
*i::
	SendInput {VK3C}
	return
*o::
	SendInput {VK3D}
	return
*p::
	SendInput {VK3E}
	return
	
	
	
*a::
	SendInput {VK3F}
	return
*s::
	SendInput {VK40}
	return
*d::
	SendInput {VK88}
	return
*f::
	SendInput {VK89}
	return
*g::
	SendInput {VK8A}
	return
*h::
	SendInput {VK8B}
	return
*j::
	SendInput {VK8C}
	return
*k::
	SendInput {VK8D}
	return
*l::
	SendInput {VK8E}
	return
	
	
	
*z::
	SendInput {VK8F}
	return
*x::
	SendInput {VK97}
	return
*c::
	SendInput {VK98}
	return
*v::
	SendInput {VK99}
	return
*b::
	SendInput {VK9A}
	return
*n::
	SendInput {VK9B}
	return
*m::
	SendInput {VKD8}
	return
	
	
	
*1::
	SendInput {VKD9}
	return
*2::
	SendInput {VKDA}
	return
*3::
	SendInput {VKE8}
	return
