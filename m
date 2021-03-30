From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Date: Tue, 30 Mar 2021 11:23:39 -0700
Message-ID: <20210330182339.GU109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
 <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
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
	 bh=DelIj1RYMg/TsK3adox4RP6yJYEo6r+9+ue1tK5rgMA=; b=PI+aHA/dE69kHMFzG+ENCCM9g
	q6r+0vIvJnmMtDuGsx9RtOU2B+R3hYEbPiU3YZqDN7UvqFvxJdMOwW1jI7jo67z613dacH/IiP8Zf
	PHUDaYgqCPZkm4UOumos2puMUZnjgR+4LlbKhFC8yIxhnGv6LFuFu92ciN9CNFOLy1IwalWwhfXUw
	illdDrYqhVPB7n/joK+b/LbqG9WPKxby4EVKvQRmlg3m4LtyH0FU03VozaU0O7NQCTt1/kOibaaMF
	O8YFBd12DWLApK2U/+YGxG2gbYoD7Vm70TO0oONlB2ehoVGk0kjv2Iwthd65M5f/DgRhtFXiYynb+
	zroVreNUg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=2604; q=dns/txt; s=iport;
 t=1617128625; x=1618338225;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xMStwoujyvRVt+OuzbkoYXvA32+qhvWOh/uecqwPFaM=;
 b=HOKvwhRGp1THDDrVjcq0hqrsPhQf9jhzOj6t2M25Zty6l28YVrQm/gpt
 yEjqgSvQ1fHwc6HMYoJ8rWqfIz1F4I/3xbaSxUEGMuMTZViAfhyEPNDEs
 sX/53oxhy3KC+CbX1f4inK0aPjnmsHsBhVaQsNHEjsybZUlVbG6IzTgc6 U=;
Content-Disposition: inline
In-Reply-To: <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
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
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, will@kernel.org, Rob Herring <robh@kernel.org>, daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, linux-mips <linux-mips@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Mar 30, 2021 at 08:07:30PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 30.03.2021 um 19:27 schrieb Daniel Walker <danielwa@cisco.com>:
> > 
> > On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> >> This code provides architectures with a way to build command line
> >> based on what is built in the kernel and what is handed over by the
> >> bootloader, based on selected compile-time options.
> >> 
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >> v3:
> >> - Addressed comments from Will
> >> - Added capability to have src == dst
> >> ---
> >> include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 57 insertions(+)
> >> create mode 100644 include/linux/cmdline.h
> >> 
> >> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> >> new file mode 100644
> >> index 000000000000..dea87edd41be
> >> --- /dev/null
> >> +++ b/include/linux/cmdline.h
> >> @@ -0,0 +1,57 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_CMDLINE_H
> >> +#define _LINUX_CMDLINE_H
> >> +
> >> +#include <linux/string.h>
> >> +
> >> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> >> +#ifndef cmdline_strlcat
> >> +#define cmdline_strlcat strlcat
> >> +#endif
> >> +
> >> +/*
> >> + * This function will append or prepend a builtin command line to the command
> >> + * line provided by the bootloader. Kconfig options can be used to alter
> >> + * the behavior of this builtin command line.
> >> + * @dst: The destination of the final appended/prepended string.
> >> + * @src: The starting string or NULL if there isn't one.
> >> + * @len: the length of dest buffer.
> >> + */
> > 
> > Append or prepend ? Cisco requires both at the same time. This is why my
> > implementation provides both. I can't use this with both at once.
> 
> Just an idea: what about defining CMDLINE as a pattern where e.g. "$$" or "%%"
> is replaced by the boot loader command line?
> 
> Then you can formulate replace, prepend, append, prepend+append with a single
> CONFIG setting.
> 
> It may be a little more complex in code (scanning for the pattern and replacing
> it and take care to temporary memory) but IMHO it could be worth to consider.

In some cases this code could be used extremely early in boot up. For example in the
prom_init.c powerpc code, or in efi changes. The flexibility to find and replace
like that is not always an option due to the nature of the environment. It's not
impossible of course.

Daniel
