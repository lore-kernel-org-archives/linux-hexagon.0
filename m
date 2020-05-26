From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel
 builds to 4.8
Date: Tue, 26 May 2020 08:30:04 -0700
Message-ID: <20200526153004.GA74229@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=an9KhWgQP+/Fji7KQ32EAN6LrJ7/yGHMUcaJcF1rPZo=;
        b=Y2DzLyU7ga/1gd25vfMIXc2hsI4Jl/HI4zlSDDOkQhLjym0fyD97OT9l7rWdxoJrU/
         Gj3F2USd8BzEhDLGRw4nN84mi1/lfHKsxlGsJm9d94hKH33e8JCz7bkqWE8HVxS4xfr4
         kAeeO3cgUL5AngjhHOzIJtBVGgGNQTTrZiUP4eoo0qO2kjoiAgOkH9JXshk4ySA7B9nm
         NGOAQj/xKe6K/sQFiMrsghgYJtRxXOTgrssil/3FzmV+HDJh+i+9JQgKdGxxcj1vJgg4
         TO2EIHLXV2MBQbfLSoYVohMTVpFDuQjuWApEa67mCt0rdBj589x73BosdSLh22w07/cP
         bVuA==
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also known to have codegen
> issues which can lead to silent miscompilation:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> 
> Raise the minimum GCC version to 4.8 for building the kernel and remove
> some tautological Kconfig dependencies as a consequence.

My hexagon compiler is v4.6.1, and I have been unable to find a more
recent version. Does anyone happen to have a pointer to a hexagon toolchain
with gcc 4.8 or later ?

Thanks,
Guenter
