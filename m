From: Rob Landley <rob@landley.net>
Subject: Re: [Q] Guest mode in HVM
Date: Wed, 06 Mar 2013 12:41:56 -0600
Message-ID: <1362595316.2980.0@driftwood>
References: <48b776bf823f2b3c978065ccc6bce7b0.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <48b776bf823f2b3c978065ccc6bce7b0.squirrel@www.codeaurora.org>
	(from rkuo@codeaurora.org on Tue Mar  5 17:53:09 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: rkuo@codeaurora.org
Cc: cotulla@yandex.ru, linux-hexagon@vger.kernel.org, erappleman@gmail.com, jonpry@gmail.com, linasvepstas@gmail.com

On 03/05/2013 05:53:09 PM, rkuo@codeaurora.org wrote:
> On Tue, Mar 5, 2013 at 11:45 AM, <cotulla@yandex.ru> wrote:
> > I have a question:
> > Did I understand right that "HVM Guest mode" is actually native  
> hexagon
> > user mode?
> > And native hexagon super mode is only used inside HVM during trap1  
> and
> > exception handlers?
> 
> On certain versions of the architecture, yes, it effectively is pushed
> into user mode.
> 
> > It's not possible to specify access mode for user/super mode in TLB.
> > ...
> > We are going to emulate separate memory access attributes (RWX) for  
> linux
> > kernel and linux user modes by using two different ASIDs for user  
> and
> > kernel mode per hw thread.
> 
> Right, the supervisor isn't subject to RWX bits, but it is still  
> subject
> to ASIDs.  I think there was some other nuance to the fault handling,  
> but
> that was the gist of it.
> 
> This brings us to hypervisors which we've sort of skirted in other  
> emails.
>  There will be changes in the Hexagon architecture from one version to
> another, some of which will affect the guest operation and  
> compatibility.
> Long term, "we" would like to have Linux just deal with the hypervisor
> interface.
> 
> Of course, that isn't useful to anybody without the actual  
> hypervisor.  We
> recognize this and are working hard to try to release some version of  
> a
> functioning hypervisor for the community to continue tinkering with.   
> If
> we get that out, perhaps that will be more preferable for you to work
> on...
> 
> That said, I think it's great that you all are motivated enough to go  
> for
> a bare metal port in the first place (and it looks like you've made  
> great
> progress).  I see no reason to reject bare metal patches, but we would
> need to keep things clean with ifdefs/config switches...
> 
> Thanks,
> Richard Kuo

I would very much like to test this once you can boot a shell prompt on  
it. Is there some kind of README about what hardware to try to snag off  
ebay or prospects for getting support in qemu? (If there's a prebuilt  
toolchain an actual URL to that would be great too.)

Rob