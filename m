From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2, 1/2] Move the pt_regs_offset struct definition from arch to common include file
Date: Tue, 18 Aug 2015 20:43:30 +1000 (AEST)
Message-ID: <20150818104330.B24DC14032B@ozlabs.org>
References: <1437971974-2434-2-git-send-email-dave.long@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1437971974-2434-2-git-send-email-dave.long@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David A. Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org

On Mon, 2015-27-07 at 04:39:33 UTC, "David A. Long" wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> The pt_regs_offset structure is used for the HAVE_REGS_AND_STACK_ACCESS_API
> feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h, along with macros commonly used to access it.

Thanks for cleaning this up. Tested successfully on powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
