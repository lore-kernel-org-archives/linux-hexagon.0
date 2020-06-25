From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 17/17] arch: rename copy_thread_tls() back to copy_thread()
Date: Thu, 25 Jun 2020 10:26:58 +0200
Message-ID: <20200625082658.GC6319@alpha.franken.de>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, linux-xtensa@linux-xtensa.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <>

On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:
> Now that HAVE_COPY_THREAD_TLS has been removed, rename copy_thread_tls()
> back simply copy_thread(). It's a simpler name, and doesn't imply that only
> tls is copied here. This finishes an outstanding chunk of internal process
> creation work since we've added clone3().
> [..]
>  arch/mips/kernel/process.c       | 2 +-

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
