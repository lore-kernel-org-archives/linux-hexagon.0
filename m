From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Date: Tue, 31 Jan 2023 16:00:22 -0800
Message-ID: <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
References: <Y9lz6yk113LmC9SI@ZenIV> <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV> <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
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
	List-Owner; bh=4i0VKAJFTD937bmNl8prdm4Gewxh5We25+Pi4qIcBBc=; b=khF2J52i3Wdz0Z
	pG2MInromMxDIKiGPQcOj1jaaz4d1Koj079XZXwEeBMypLOOqfNNTL/nk4HLI4DY3SHJD6fBWLsXy
	2VrT1oMsRTLUsu3TjBuO+ju9l5qUQbu+bGH2/wFwx+s82z11cWSQXS6FxUQbIFFj/tIS6rAeboQJa
	xIPzNl78iX2KvT7c+5xCADuWeJnBeD+qB3l4Xiuoggy/qU79wTASCKv4UDcY3AwZoIkNvtVBIdWVa
	aZEfzTCgb1BaYtAB4hp2P4vkB2GKbaYA1PTFkh04CRxPoHFpN01m6xPP4Fb/jm9m2OMAe6c5S9pyW
	/4ADq19B63fuJnxeJwEQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRCOdD9CD/IiFJ43pipYPy+q1tidOpGH1rcqkIGuMSQ=;
        b=fL59Ab7RHJP0bfIYtovRgam/bmLVqgi/HuOZuRtvXpi8XPCKPsz19TVQkwQ/4pcElK
         nbpNee2j9nRk73RFGNcIlDQDDv7dgJ9GC8xvsYkG1wEa43drPEZkLrJIAfsAF0ElYFBV
         ZenNmi1Qr0FBP87JP4qtwax7RH2E68mH3aIp0=
In-Reply-To: <Y9mM5wiEhepjJcN0@ZenIV>
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
Cc: Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org

On Tue, Jan 31, 2023 at 1:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Everything else seems to be going with EFAULT.

So I think fo kernel faults it's always basically up to the exception
handler, and sending a signal regardless of that is just wrong.

Of course, an exception handler might choose to send a signal, but it
just shouldn't be the do_page_fault() handler that does it.

For user faults, I think the rule ends up being that "if there's no
mapping, or if there is a protection fault, then we should do
SIGSEGV".

If there's an actual mapping in place, and the mapping has the right
permissions for the access, but fails for some *other* reason, then we
send SIGBUS.

So a shared mmap past the end of the file (but within the area that
was used for mmap) would SIGBUS, while a write to a read-only mapping
would SIGSEGV.

Things like unaligned accesses also might SIGBUS rather than SIGSEGV.

And I'm not surprised that there are exceptions to the rule, because
almost nothing really cares. In most situations, it's a fatal error.
And even when catching them, the end result is generally the same
(either "print out helpful message and die", or "longjump to some safe
code").

So most of the time it's probably not going to matter all that much
which signal gets sent in practice.

            Linus
