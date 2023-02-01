From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Date: Wed, 1 Feb 2023 11:51:34 -0800
Message-ID: <CAHk-=whYidrLJSq80s8C0LSui_h9164cxG6WNV1M77Tk_2QFug@mail.gmail.com>
References: <Y9lz6yk113LmC9SI@ZenIV> <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV> <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <8f60f7d8-3e2f-2a91-c7a3-6a005d36d7d3@gmx.de>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLOt8Htpi1Up/DCPSKgd2HVLgjbb3KJvZ9wNHdxeIi0=;
        b=F70AJ99pkUxssTeL0XhQsULJ+i1q3hIfT9mQJxKYXMRcGN/4hPjNKQXfjgd8TBqpBG
         BetUorZ/VTlYCLAfd+XP2RRKW0JVrfaxYcX4T9dpsWXY9GYLSKeTv64OlMI8Kd6WjuJ/
         BWyXoO4myVBwLlBRPvXQouhFGSPXaEWcUSKkI=
In-Reply-To: <8f60f7d8-3e2f-2a91-c7a3-6a005d36d7d3@gmx.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org

On Wed, Feb 1, 2023 at 12:21 AM Helge Deller <deller@gmx.de> wrote:
>
> AFAICS, the only applications which really care about the return
> code are
> - testsuites like LTP (i.e. the fstat05 testcase)

Those have actually shown issues with various library implementations,
exactly because real system calls act very differently in this area
from library wrappers.

Things like the vdso implementation of gettimeofday() get a SIGSEGV if
the timeval or timezone pointer is invalid, while the "real system
call" version returns -1/EFAULT instead.

And very similar things happen when glibc ends up wrapping system
calls and converting buffers manually. At some point, glibc had a
special 'struct stat' and basically converted the native system call
to it, so you did 'stat()' on something, and it ended up actually
using a private on-stack buffer for the system call, followed by a
"convert that kernel 'struct stat' to the glibc 'struct stat'" phase.
So once again, instead of -1/EFAULT, you'd first have a successful
system call, and then get a SIGSEGV  in glibc.

And as you say, test suites would notice. But no actual normal app
would ever care.

Of course, there's always the abnormal apps. There _are_ the odd cases
that actually catch faults and fix them up, and can then be confused
by changes like that.

It's very very rare, but it happens - things like emulators do tend to
do some really strange things.

         Linus
