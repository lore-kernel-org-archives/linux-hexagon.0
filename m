From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH 09/10] riscv: fix livelock in uaccess
Date: Mon, 06 Feb 2023 21:06:31 +0100
Message-ID: <87h6vyimns.fsf@all.your.base.are.belong.to.us>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l02DvS6CYThTEG@ZenIV>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675713994;
        bh=3Yg7D05MkzSc67p0IllIeOFYuHpgtoWHEDyGg89cEn4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TrFanAIL/NQxsb91JvfkKgGGInV2GbJv83xXwVospLmonVoYF0qugCWhOe08RPwaX
         KSz2R1yQLjbocys0qpEKTIJcvGgasxF/iufKfZWM+KLnESrINJ3xvu3fY01VN9IBBd
         A14tJwz1NoSgpuJDM1gKfn9n4bZjtVGyWg1FSCcjcagioOTF4tpLoxfVEQ3ZgZwQ/X
         1DTz425W+yIiGefj9MW9+XxaZDTOhpCSDxfOWIbHdEj1cNpx4bg45I7e94f2NXzAcH
         p/5XOjHti0H5HYdlYMgGbFgyQK/fMQnqBl9p3+VIiziorpSavNm5enxgwyrcpj7Rpb
         iz3O+/RqhOzlA==
In-Reply-To: <Y9l02DvS6CYThTEG@ZenIV>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>

Al Viro <viro@zeniv.linux.org.uk> writes:

> riscv equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY han=
dling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we=
 might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anyt=
hing
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we n=
eed
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reproduced with Mark's userland program -- thanks!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
