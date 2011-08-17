From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 01/36] Hexagon: Add generic headers
Date: Wed, 17 Aug 2011 21:19:07 +0200
Message-ID: <1652013.0Mm3aOmd9K@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163519.957524170@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163519.957524170@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:34:58 Richard Kuo wrote:
>  arch/hexagon/include/asm/bug.h               |    1 
>  arch/hexagon/include/asm/cpumask.h           |    1 
>  arch/hexagon/include/asm/cputime.h           |    1 
>  arch/hexagon/include/asm/device.h            |    1 
>  arch/hexagon/include/asm/div64.h             |    1 
>  arch/hexagon/include/asm/emergency-restart.h |    1 
>  arch/hexagon/include/asm/errno.h             |    1 
>  arch/hexagon/include/asm/fb.h                |    1 
>  arch/hexagon/include/asm/fcntl.h             |    1 
>  arch/hexagon/include/asm/ioctl.h             |    1 
>  arch/hexagon/include/asm/ioctls.h            |    1 
>  arch/hexagon/include/asm/ipc.h               |    1 
>  arch/hexagon/include/asm/ipcbuf.h            |    1 
>  arch/hexagon/include/asm/irq_regs.h          |    1 
>  arch/hexagon/include/asm/kdebug.h            |    1 
>  arch/hexagon/include/asm/kmap_types.h        |    1 
>  arch/hexagon/include/asm/local.h             |    1 
>  arch/hexagon/include/asm/local64.h           |    1 
>  arch/hexagon/include/asm/mman.h              |    1 

There is no need for these one-line files any more, see
arch/openrisc/include/asm/Kbuild

	Arnd
