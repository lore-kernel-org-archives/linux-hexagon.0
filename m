From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 17/17] arch: rename copy_thread_tls() back to copy_thread()
Date: Fri, 26 Jun 2020 06:17:49 +0900
Message-ID: <20200625211749.GH1401039@lianli.shorne-pla.net>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CYdo0/N2hPQ38RsTOzG1HX78I9n3NR49FO824e6zLtQ=;
 b=FDoOD71AUBcdqMd1QpOGzqSOfHIfeqUX9WRT2uVYBig3mcL8Etxvpb8vKA19DXCEHk
 hGGyn1qQff5t9NyGd0lso3F1GiQRnyM9Thb1X3Q9nK5u7AM24Qpc5yMKBaX3ULrGDdmI
 aW3HUYFlAs8muNXQr2XbluBC6XcTXX0ykUXQ1EzqTydZoE90RxOfVwphYK6gTw5MJDP9
 mgw88O7NpAvmCyIxt25IifP2Bt29eyhNzOX/15SZvv0sU/nuxlLY/V8fYEtI3N0b3pKT
 gp2NuMwvUxbTosGypDo6A5687Z6EsY8/j4IN6ojCLjAHh/Y+rVlTIkural2QcqlX4Tvf
 Rmrg==
Content-Disposition: inline
In-Reply-To: <20200622234326.906346-18-christian.brauner@ubuntu.com>
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
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, linux-xtensa@linux-xtensa.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <l>

On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:

> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index d7010e72450c..19045a3efb8a 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -116,7 +116,7 @@ void release_thread(struct task_struct *dead_task)
>  extern asmlinkage void ret_from_fork(void);
>  
>  /*
> - * copy_thread_tls
> + * copy_thread
>   * @clone_flags: flags
>   * @usp: user stack pointer or fn for kernel thread
>   * @arg: arg to fn for kernel thread; always NULL for userspace thread
> @@ -147,7 +147,7 @@ extern asmlinkage void ret_from_fork(void);
>   */
>  
>  int
> -copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> +copy_thread(unsigned long clone_flags, unsigned long usp,
>  		unsigned long arg, struct task_struct *p, unsigned long tls)
>  {

For the OpenRISC bit.

Acked-by: Stafford Horne <shorne@gmail.com>

Also, I would agree with what Kees mentioned about aligning the parameters.
Sure that would be more work but it would be appreciated.

-Stafford
