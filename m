From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 12/20] powerpc/ps3: Convert half completion to rcuwait
Date: Sat, 21 Mar 2020 14:22:03 +0100
Message-ID: <87v9mxrgg4.fsf@nanos.tec.linutronix.de>
References: <20200321112544.878032781@linutronix.de> <20200321113241.930037873@linutronix.de>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200321113241.930037873@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>

That's obviously bogus and wants to be:

From: Peter Zijlstra (Intel) <peterz@infradead.org>

