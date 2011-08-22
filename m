From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: __ARCH_WANT_SYSCALL_DEPRECATED
Date: Mon, 22 Aug 2011 14:36:02 -0500
Message-ID: <20110822193602.GA23301@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Arnd Bergmann <arnd@arndb.de>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexag


Hi,

So: What's the latest on asm-generic support on glibc?=20
I just pulled glibc-2.14 and note that Chris Metcalf's
generic implementation hasn't been folded in yet.=20
It seems to work well for me, so can we expect it
anytime soon?

Another problem:  If I don't define __ARCH_WANT_SYSCALL_DEPRECATED
in the kernel asm/unistd.h  then glibc won't build: currently,
I get=20
=2E./sysdeps/unix/sysv/linux/getdents.c:105: error: =E2=80=98__NR_getde=
nts=E2=80=99 undeclared (first use in this function)

A very quick grep tells me that asm-generic defines a getdents64
but that is not what glibc is looking for.  Is there any chance
that there are glibc patches floating around somewhere that heal
this and any remaining __ARCH_WANT_SYSCALL_DEPRECATED issues?

--linas=20
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
