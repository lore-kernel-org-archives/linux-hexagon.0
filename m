From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 17/17] arch: rename copy_thread_tls() back to copy_thread()
Date: Sat, 4 Jul 2020 18:10:31 +0200
Message-ID: <20200704161031.lcln4ez6yehgffgq@wittgenstein>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
 <20200625211749.GH1401039@lianli.shorne-pla.net>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20200625211749.GH1401039@lianli.shorne-pla.net>
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
To: Stafford Horne <shorne@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, linux-xtensa@linux-xtensa.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <l>

On Fri, Jun 26, 2020 at 06:17:49AM +0900, Stafford Horne wrote:
> On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:
> 
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index d7010e72450c..19045a3efb8a 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -116,7 +116,7 @@ void release_thread(struct task_struct *dead_task)
> >  extern asmlinkage void ret_from_fork(void);
> >  
> >  /*
> > - * copy_thread_tls
> > + * copy_thread
> >   * @clone_flags: flags
> >   * @usp: user stack pointer or fn for kernel thread
> >   * @arg: arg to fn for kernel thread; always NULL for userspace thread
> > @@ -147,7 +147,7 @@ extern asmlinkage void ret_from_fork(void);
> >   */
> >  
> >  int
> > -copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> > +copy_thread(unsigned long clone_flags, unsigned long usp,
> >  		unsigned long arg, struct task_struct *p, unsigned long tls)
> >  {
> 
> For the OpenRISC bit.
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
> Also, I would agree with what Kees mentioned about aligning the parameters.
> Sure that would be more work but it would be appreciated.

Sure, this is a mechanical change. I'll update the individual patches to account for that.

Thanks!
Christian
