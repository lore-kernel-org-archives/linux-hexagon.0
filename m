From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 17/17] arch: rename copy_thread_tls() back to copy_thread()
Date: Mon, 22 Jun 2020 17:46:56 -0700
Message-ID: <202006221745.5999CF5@keescook>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zu4OU7IGZiTsvIaDwmyLbj4I9ozbACkG/Mn2gAIRkbg=;
 b=eD2zNURLgHPqg/d00zOemVc/uWc9XFUrQc9T/r0CfHnQ37J5w12dtxWOt/XLxUaoPr
 oPBZAAlU/s8JvF08Eg5Uwe6Yf/qJtxl/cKLc4YjjZ2omXW0o0Dck4uICr1tn5iEyOb+s
 XrFSioDSrXqS4AKWpDQOm1ZEp45q7IQaD6sek=
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
> [...]
> -copy_thread_tls(unsigned long clone_flags, unsigned long user_stack_base,
> +copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
>  		    unsigned long user_stack_size, struct task_struct *p,
>  		    unsigned long tls)

Maybe clean up the arg indentation too? I'm not sure how strongly people
feel about that, but I think it'd be nice.

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
