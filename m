From: rkuo <rkuo@codeaurora.org>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Mon, 18 Feb 2013 22:36:05 -0600
Message-ID: <20130219043605.GB12127@codeaurora.org>
References: <1093431360938494@web22d.yandex.ru>
 <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru>
 <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1163031361018389@web26d.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On Sat, Feb 16, 2013 at 04:39:49PM +0400, cotulla@yandex.ua wrote:
> > =A0Don't know v2. But v3 had a 'real' MMU
> Hm, are you sure in that?=20
> I had never seen any usage of it. As well as binutils registers defin=
ition doesn't include any suitable registers for that.=20

Both have an MMU, but both are software managed.  That's one of the
functions that the hypervisor provides for us.

=20
> > =A0Good, because the bootloader was going to be the other issue.
> Yes, in my case it's working :)
> But another guys who also want participate in this project with MSM89=
60/APQ8064 they still can't run any unsigned code on Q6.
> In modern phones it's often locked from changes :(

Congrats on getting the bootloader working.

Linas already answered some of your questions (thanks Linas!)

Hexagon Linux so far has been just used on internal projects; it's
not a part of any products even though the processor itself is.  A
non-hypervisor port is certainly possible, but for our purposes
around here, it's always running under the hypervisor.


Thanks,
Richard Kuo


--=20

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
hosted by The Linux Foundation
