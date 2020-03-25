From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: Documentation/locking/locktypes: Further clarifications and
 wordsmithing
Date: Wed, 25 Mar 2020 17:02:12 +0100
Message-ID: <20200325160212.oavrni7gmzudnczv@linutronix.de>
References: <20200323025501.GE3199@paulmck-ThinkPad-P72>
 <87r1xhz6qp.fsf@nanos.tec.linutronix.de>
 <20200325002811.GO19865@paulmck-ThinkPad-P72>
 <87wo78y5yy.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wo78y5yy.fsf@nanos.tec.linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Da

On 2020-03-25 13:27:49 [+0100], Thomas Gleixner wrote:
> The documentation of rw_semaphores is wrong as it claims that the non-owner
> reader release is not supported by RT. That's just history biased memory
> distortion.
> 
> Split the 'Owner semantics' section up and add separate sections for
> semaphore and rw_semaphore to reflect reality.
> 
> Aside of that the following updates are done:
> 
>  - Add pseudo code to document the spinlock state preserving mechanism on
>    PREEMPT_RT
> 
>  - Wordsmith the bitspinlock and lock nesting sections
> 
> Co-developed-by: Paul McKenney <paulmck@kernel.org>
> Signed-off-by: Paul McKenney <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
…
> +rw_semaphore
> +============
> +
> +rw_semaphore is a multiple readers and single writer lock mechanism.
> +
> +On non-PREEMPT_RT kernels the implementation is fair, thus preventing
> +writer starvation.
> +
> +rw_semaphore complies by default with the strict owner semantics, but there
> +exist special-purpose interfaces that allow non-owner release for readers.
> +These work independent of the kernel configuration.

This reads funny, could be my English. "This works independent …" maybe?

Sebastian
