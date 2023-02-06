From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
Date: Mon, 6 Feb 2023 13:08:59 +0100
Message-ID: <CAMuHMdWcNcn7R6MMeg51SUkmpZZ+HpdsMtiOE55EbQ1coc10AQ@mail.gmail.com>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0aBPUEpf1bci9@ZenIV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/8K/4rgH3Hd5z4YuyQR9oZT5bG7YKE25bEiJplk3Jyc=; b=S7w+GsoNyf9UYM
	32tiCjt4B0xKyOUuAcTSFuJBTOrHSyC0xxeFxhZFnSEkl7g6QqKh8i4DUFV60GtU44+gW6T9Xc0cU
	jInquzzKjMEbXXDDJrx4EP7OXLnkjuhxyVyFyPw9GDVNKS/mgVUCd6IS/Ak533KXkTWIWR7TVbKvt
	fcHcushnpQuzds025LhC8cxcOJoI3BhoVyazaMUvLb7GZNOP8W5cvhlBj2rSS2qHCZley9axb8PGg
	fLhfTD+N2yGaB2O6GDCjWFYMr50Nf4jE59067NP5a1W/jfZvG4uMVpulHFuosCjoK555j/Q2AL+ui
	g7sUcjRuwrs7zMm2LibQ==;
In-Reply-To: <Y9l0aBPUEpf1bci9@ZenIV>
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
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Jan 31, 2023 at 9:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> m68k equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
