From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Sat, 31 Jul 2021 08:50:00 +0200
Message-ID: <YQTymISw2nXxDSGu@osiris>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vy2ZrZHsOiywBYkkMjbRwYeQYsYc3tLJ6X42L771TNI=; b=4gKT0bOb1j+bq/
	TiYocwWYapzoOgsVuj97gIjxILgIR3RKfGnQ7TwEOYHB3siRLGlpY6ygSw0FQ9jdjl0XgfFGHMexp
	rCcXcVl2Hsc2pn/28y3w9zf6E8peKx9xtZmPSc+hNh6fKg7wZrSVoUOk9tsvV20co5pjKDOjx6SPP
	Jk7FjwBbAqi6m2ZrYD+kUBj6VKX+UkiGp43wITuzFI32XXhp6YCYVByg/yKl/TubXtxM60kMdEKxD
	d70IPA4myQQETV5Mu1bEsLefG9zDkt3fg+47S7hBBRGSX+o8LDkFfkIBGYGThCHsJXH6BGg3PVeEQ
	GHuGSQOlY0GW8Exvgn5Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AykrfsFgkMAYLNg2w36lRGIX3leux4UCoOOR3djqTLk=;
 b=hfejmFW+fXsOsLjD+mu8ZUTBnuS4CofZfnheKQKaT8a2RLuIIciO8wwpdydUxCYZzqls
 YavwCO3kmcbYvdwtIYcHCK4z/HQ+JEMl27G6d0fQtKPQ19/I8LfIPC4tqRtknJAZijrA
 EtZov9BGRDi1hH8vhvca0WInmSLH840nS0EuvlDPSn9pAPdeJr8o6eJRK+cdfU6JVfQ8
 QjAPDcmiTyhI5FB9XJ+2Pv5G2sbhuG3VOtmyVEbQbO8iaDci110hYw94PoZGVctBsyvJ
 haC/x/MvVLXh5ldbSUHSC+JOMCOyj6GkIFI14qhLTYhpjpd6+iIm+gfUhzF9t0pbvGT1 ag== 
Content-Disposition: inline
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, x86@kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Uwe

On Sat, Jul 31, 2021 at 02:22:32PM +0900, Masahiro Yamada wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
...
>  arch/s390/Kconfig             | 1 +
>  arch/s390/Kconfig.debug       | 3 ---

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
