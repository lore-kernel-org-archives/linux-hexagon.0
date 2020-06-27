From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 16/17] arch: remove HAVE_COPY_THREAD_TLS
Date: Sat, 27 Jun 2020 11:06:08 +0800
Message-ID: <CAEbi=3f3o5jS7zZDo50Vq857mS9n9kDsxkseGKrWshmmp3q5wA@mail.gmail.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-17-christian.brauner@ubuntu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+vuS6c1B6RhJf/Wc0BlkKUed8Ad7RKtG6ySIxBvmEW4=;
 b=gGSSgpkEGydgQhXoMv3qlsLt5mrlAk1v4a9rb3qIZhmM949nYvicKoTtRuPavC2CPS
 4gqA1cK6C7En4OrR24pSzu/xs4Q8Gi1+rCDB936ZFtDq7qeIhGdqLhX3QVnpV1gh8i9r
 Yr+oBV7orOZer/ucN8JKx+INZnGVhvWI3lJGYoToY83TNPCD/UDAOaXkBbXLVet7FzJU
 YdFda7nN//WQKfslSPDlW95hAsPb2mC0SvZh10iM7adIharPZOJYAapANRg5t3Qkk2Sr
 ISnw9Cflf3OgJKj3vsBG2CTZKXRPGRjLof1FkbQqiDaWgHWLcla93tfKhCRAOkB8QJ9C
 IkQQ==
In-Reply-To: <20200622234326.906346-17-christian.brauner@ubuntu.com>
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
Content-Type: text/plain; charset="utf-8"
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, linux-s390 <linux-s390@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, linux-xtensa@linux-xtensa.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley

Christian Brauner <christian.brauner@ubuntu.com> =E6=96=BC 2020=E5=B9=B46=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=887:46=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> All architectures support copy_thread_tls() now, so remove the legacy
> copy_thread() function and the HAVE_COPY_THREAD_TLS config option. Everyo=
ne
> uses the same process creation calling convention based on
> copy_thread_tls() and struct kernel_clone_args. This will make it easier =
to
> maintain the core process creation code under kernel/, simplifies the
> callpaths and makes the identical for all architectures.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: "Matthew Wilcox
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-csky@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> [...]
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index 7b6eaca81cce..e30298e99e1b 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -48,7 +48,6 @@ config NDS32
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_DYNAMIC_FTRACE
> -       select HAVE_COPY_THREAD_TLS
>         help
>           Andes(nds32) Linux support.

Hi Christian, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
