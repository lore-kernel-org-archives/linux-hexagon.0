From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Date: Tue, 30 Mar 2021 20:07:30 +0200
Message-ID: <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:In-Reply-To:From:
	Mime-Version:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9lRpDzV/J3HAZSakERbzolYHYnd2uK0zKnXVxje99sA=; b=MIdMImlIf8LGipRAHlDANHn9D
	P4snWs9gakjqYgRTlrlcPaoMM2xTput4U6ImH4ZtHNoRf9wqfdKRyUcLPz62UFn4oxJ3BtEh7pKmO
	oKmme1AqQO0RTME5ulJvFk9bNVYwaqKxyEai7nVnQ1RHSd6zDdu34LTHUWC6uHS5DD1AdRZQuEebD
	hFteZ5Q7TXIxH9YNm6ynYPRwk+DJ/cSAvpKrCOoSAJQEkUkxeJEOmKbTaJPFdJbNZ+O/7crjcVsoY
	BghHvtQrrZNkakLkOhjAhSSiIw5TVyZL/UPJ/R2nKy/BJdFiyMsBss7vqRZLswV6fnZVldd0aGJxo
	EnJDRZkTQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1617127652;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=TBtxdLUkTjgMvDEB4mRh0JBbXrVFmzYUj0lLVMFFsdA=;
 b=mbDZevjFp2b5R5VUle8FDC8MwkfYJzBYGCwkaBTe2ybLg6GWxZEJsH5woKenUz96DZ
 HLCOwfabBd5h1GPxw3d1/qdKw063SU3JfrMvJjSZc4etXqVgZ2OuBchcRp0XGZjLqw0Q
 XI9sVLA8HjveKwrt594YK3I6FiUVUxeNeTlYhNwAe6WYcF1jzcOR6pVtqoJP9uP/xZ/D
 Syv6uzaw6Ma5RlMrYSJzO01MZ2ln4j1+WzqLWaT+SnK0MZvUpV72FVIyBP3MJRqqvVES
 dGUeryXh/+ZW1PiQ4IEXCAuRPM4Xx3PnN8Xk5C5+DltqN18M43BTURpT9dF2flHnmD8l
 liYA==
In-Reply-To: <20210330172714.GR109100@zorba>
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
To: Daniel Walker <danielwa@cisco.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: will@kernel.org, Rob Herring <robh@kernel.org>, daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, linux-mips <linux-mips@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org


> Am 30.03.2021 um 19:27 schrieb Daniel Walker <danielwa@cisco.com>:
> 
> On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
>> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3:
>> - Addressed comments from Will
>> - Added capability to have src == dst
>> ---
>> include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 57 insertions(+)
>> create mode 100644 include/linux/cmdline.h
>> 
>> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>> new file mode 100644
>> index 000000000000..dea87edd41be
>> --- /dev/null
>> +++ b/include/linux/cmdline.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CMDLINE_H
>> +#define _LINUX_CMDLINE_H
>> +
>> +#include <linux/string.h>
>> +
>> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
>> +#ifndef cmdline_strlcat
>> +#define cmdline_strlcat strlcat
>> +#endif
>> +
>> +/*
>> + * This function will append or prepend a builtin command line to the command
>> + * line provided by the bootloader. Kconfig options can be used to alter
>> + * the behavior of this builtin command line.
>> + * @dst: The destination of the final appended/prepended string.
>> + * @src: The starting string or NULL if there isn't one.
>> + * @len: the length of dest buffer.
>> + */
> 
> Append or prepend ? Cisco requires both at the same time. This is why my
> implementation provides both. I can't use this with both at once.

Just an idea: what about defining CMDLINE as a pattern where e.g. "$$" or "%%"
is replaced by the boot loader command line?

Then you can formulate replace, prepend, append, prepend+append with a single
CONFIG setting.

It may be a little more complex in code (scanning for the pattern and replacing
it and take care to temporary memory) but IMHO it could be worth to consider.

BR,
Nikolaus Schaller
