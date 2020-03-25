From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: Documentation/locking/locktypes: Further clarifications and
 wordsmithing
Date: Wed, 25 Mar 2020 17:54:22 +0100
Message-ID: <20200325165422.hfxzkxcj3jhqcstr@linutronix.de>
References: <20200323025501.GE3199@paulmck-ThinkPad-P72>
 <87r1xhz6qp.fsf@nanos.tec.linutronix.de>
 <20200325002811.GO19865@paulmck-ThinkPad-P72>
 <87wo78y5yy.fsf@nanos.tec.linutronix.de>
 <20200325160212.oavrni7gmzudnczv@linutronix.de>
 <20200325163919.GU19865@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200325163919.GU19865@paulmck-ThinkPad-P72>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@v

On 2020-03-25 09:39:19 [-0700], Paul E. McKenney wrote:
> > > --- a/Documentation/locking/locktypes.rst
> > > +++ b/Documentation/locking/locktypes.rst
> > …
> > > +rw_semaphore
> > > +============
> > > +
> > > +rw_semaphore is a multiple readers and single writer lock mechanism.
> > > +
> > > +On non-PREEMPT_RT kernels the implementation is fair, thus preventing
> > > +writer starvation.
> > > +
> > > +rw_semaphore complies by default with the strict owner semantics, but there
> > > +exist special-purpose interfaces that allow non-owner release for readers.
> > > +These work independent of the kernel configuration.
> > 
> > This reads funny, could be my English. "This works independent …" maybe?
> 
> The "These" refers to "interfaces", which is plural, so "These" rather
> than "This".  But yes, it is a bit awkward, because you have to skip
> back past "readers", "release", and "non-owner" to find the implied
> subject of that last sentence.
> 
> So how about this instead, making the implied subject explicit?
> 
> rw_semaphore complies by default with the strict owner semantics, but there
> exist special-purpose interfaces that allow non-owner release for readers.
> These interfaces work independent of the kernel configuration.

Yes, perfect. Thank you.

> 							Thanx, Paul

Sebastian
