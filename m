From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Date: Tue, 31 Jan 2023 21:10:46 +0000
Message-ID: <Y9mD1qp/6zm+jOME@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ax3PgYwLD1J7idHBX3HJFIuaDhcl8qpAf80zjHGbIOE=; b=ijKot8fh7fbodyAsqMzVpj0Cd/
        VRhb3o6VGsSZwFzUgydtCMao2SRAc6OvQbKgKTgF95uP5svS4C/FxCqcqUX86wc84kQEXVbEPB7wS
        rN+Xso/B3SrMGqO5wEnGdYpYTNTo/fdm4TakUXxCmvcsIkqePXpvogyNY4WqFatodwbca/GXe/IZq
        TGTiUMc3omsIAXO69lh7VVjaJ9HjeeYC3SLP2MDqgIcLqjc0YsTzOFdqGG/tpU1bxLpogucTBRm16
        qsgaiC/gb9QmZbQNmm8axQf5ucRwx/M7yQhEY+AOFMpn3cAcoHodK3a6Dtut3nhZNK43ZjcPwYxi3
        AIsaudwg==;
Content-Disposition: inline
In-Reply-To: <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org

On Tue, Jan 31, 2023 at 12:24:54PM -0800, Linus Torvalds wrote:

> But *if* the alpha code were to just translate it into the
> FAULT_FLAG_xyz namespace, apretty much *all* of the alpha
> do_page_fault() could have been then done by a completely generic
> "generic_page_fault()" that has all of the retry logic, all of the
> si_code logic, etc etc.

Umm...  What about the semantics of get_user() of unmapped address?
Some architectures do quiet EFAULT; some (including alpha) hit
the sucker with SIGBUS, no matter what.

Examples:
arm
        if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
		return 0;

	/*
	 * If we are in kernel mode at this point, we
	 * have no context to handle this fault with.
	 */
	if (!user_mode(regs))
		goto no_context;
	...
alpha
 do_sigbus:
        mmap_read_unlock(mm);
        /* Send a sigbus, regardless of whether we were in kernel
           or user mode.  */
        force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address);
        if (!user_mode(regs))
                goto no_context;
        return;

Are we free to modify that behaviour, or is that part of arch-specific
ABI?
