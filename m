From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 00/20] Lock ordering documentation and annotation for lockdep
Date: Sat, 21 Mar 2020 18:45:38 +0100
Message-ID: <87mu89r48t.fsf@nanos.tec.linutronix.de>
References: <20200321112544.878032781@linutronix.de> <20200321171902.xxlnpikc65wd3b4m@linux-p48b>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200321171902.xxlnpikc65wd3b4m@linux-p48b>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-drive

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Sat, 21 Mar 2020, Thomas Gleixner wrote:
>
>>This is the third and hopefully final version of this work. The second one
>>can be found here:
>
> Would you rather I send in a separate series with the kvm changes, or
> should I just send a v2 with the fixes here again?

Send a separate series please. These nested threads are hard to follow.

Thanks,

        tglx
