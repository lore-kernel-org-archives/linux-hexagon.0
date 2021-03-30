From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Date: Tue, 30 Mar 2021 10:27:14 -0700
Message-ID: <20210330172714.GR109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+zABfrcNuAWIP8fvhsLVUWOiJIkq+bCCPg5FFnz6UOc=; b=ASDILX69SaGIrHpJM2qQl+ZrL
	l0O65dgiqm2vrb8wqhmh9CUqNvnPVdS6G/UBGTHZG7okCBHezI2oGeCBUNI8vDqsTYudWOxkfzR+V
	kHeKrmbRr0m1lrBv185jy+VLDskNBAWqi7bgD+1y9R65fNciPSqk9m+8MPSME470Sf0MeLKRKtbiu
	YAzP0HPTNYz6fnlWERyIjTCPnVRKI8CyLDx+7YkI8HDQogdxv1H6UY15hR2dthAf3gEt99TlD+b2s
	WGCqo9ceG4dm091pkwZ1d7TW/zQRUSYt5LOe96mrULqYspQseLEDx0WFaAtrWsr38F7Xv0LMAJs9d
	+7XWm239w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1640; q=dns/txt; s=iport;
 t=1617125244; x=1618334844;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DLlq6Eg2HUUvE9Fdg0Ebob6Tw5pX5R4uRXQoNV4sDwc=;
 b=AZ/drV3Wsv41owZ2NuZOdxoA8nTddNyk+eV/sp/13WYgrgFBYjT5oEwC
 6eczwoU1uQdLWtDyPcr6e5wKY1DN0A2EGJMXo3TxAQizmdTfZXj0ZKCT7
 SvAywcgfgOQ+rtfU/zG6BUD9omFdFLEu+Nf54mvwZ5eDCzABulq2MT1W3 8=;
Content-Disposition: inline
In-Reply-To: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: will@kernel.org, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Addressed comments from Will
> - Added capability to have src == dst
> ---
>  include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 include/linux/cmdline.h
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..dea87edd41be
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +#include <linux/string.h>
> +
> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> +#ifndef cmdline_strlcat
> +#define cmdline_strlcat strlcat
> +#endif
> +
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dst: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one.
> + * @len: the length of dest buffer.
> + */

Append or prepend ? Cisco requires both at the same time. This is why my
implementation provides both. I can't use this with both at once.

Daniel
