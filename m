From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [patch V3 04/20] orinoco_usb: Use the regular completion
 interfaces
Date: Sun, 22 Mar 2020 16:42:46 +0200
Message-ID: <87pnd4bgd5.fsf@kamboji.qca.qualcomm.com>
References: <20200321112544.878032781@linutronix.de>
 <20200321113241.150783464@linutronix.de>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1584888198; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8ZrWvNR4lZD7mLPZKWh5kIh2oW3QrCXRdxOVL7dTNX0=;
 b=vTbnNMEnuWIeG+3Ne5I1AmhndbfvwHKeAUK7K2takb4KnlUwpB8y99rGYxOdUwjEy1P7HRgp
 4O8KyjXmMr/0BsN5kqX5L5EXpvqbY/6hf1arzBwUUu/xpR3QlVBXw/ut75C2LhZMbcGIE75v
 H7RQA4n2+8UCznH3WEuq2KynK5U=
In-Reply-To: <20200321113241.150783464@linutronix.de> (Thomas Gleixner's
 message of "Sat, 21 Mar 2020 12:25:48 +0100")
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: , Randy Dunlap <rdunlap@infradead.org>, linux-ia64@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org, Sebastian Siewior <bigeasy@linutronix.de>, tel.com@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Vincent Chen <deanbo422@gmail.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-acpi@vger.kernel.org, linux-hexagon@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-csky@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, 

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> The completion usage in this driver is interesting:
>
>   - it uses a magic complete function which according to the comment was
>     implemented by invoking complete() four times in a row because
>     complete_all() was not exported at that time.
>
>   - it uses an open coded wait/poll which checks completion:done. Only one wait
>     side (device removal) uses the regular wait_for_completion() interface.
>
> The rationale behind this is to prevent that wait_for_completion() consumes
> completion::done which would prevent that all waiters are woken. This is not
> necessary with complete_all() as that sets completion::done to UINT_MAX which
> is left unmodified by the woken waiters.
>
> Replace the magic complete function with complete_all() and convert the
> open coded wait/poll to regular completion interfaces.
>
> This changes the wait to exclusive wait mode. But that does not make any
> difference because the wakers use complete_all() which ignores the
> exclusive mode.
>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> V2: New patch to avoid conversion to swait functions later.
> ---
>  drivers/net/wireless/intersil/orinoco/orinoco_usb.c |   21 ++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

I assume this is going via some other than wireless-drivers so:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
