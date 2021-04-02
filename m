From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Date: Fri, 2 Apr 2021 17:23:32 +0200
Message-ID: <53aa0b8c-4ee3-a6af-6fb8-2edc5cd79ea5@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
Content-Language: fr
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>, Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, "open list:MIPS" <linux-mips@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, Openrisc <openrisc@lists.librecores.org>, linux-hexagon@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org, SH-Linux <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>



Le 26/03/2021 à 16:42, Rob Herring a écrit :
> On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
> 
> Note that I have this patch pending:
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210316193820.3137-1-alex@ghiti.fr/
> 
> It's going to need to be adapted for this. I've held off applying to
> see if this gets settled.

When reworking EFI, I found out that they are a similar handling, which in addition takes care of 
space inside quotes.

I added something similar now in cmdline_build() function.


> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3:
>> - Addressed comments from Will
>> - Added capability to have src == dst
>> ---
>>   include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 include/linux/cmdline.h
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
>> +static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
>> +{
>> +       if (!len || src == dst)
>> +               return;
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
>> +               dst[0] = 0;
>> +               cmdline_strlcat(dst, CONFIG_CMDLINE, len);
>> +               return;
>> +       }
>> +
>> +       if (dst != src)
>> +               dst[0] = 0;
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
>> +               cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
>> +
>> +       cmdline_strlcat(dst, src, len);
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> 
> Should be APPEND.
> 
>> +               cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
>> +}
>> +
>> +#define cmdline_build(dst, src, len) do {                              \
> 
> Perhaps a comment why we need this to be a define.
> 
>> +       char *__c_dst = (dst);                                          \
>> +       const char *__c_src = (src);                                    \
>> +                                                                       \
>> +       if (__c_src == __c_dst) {                                       \
>> +               static char __c_tmp[COMMAND_LINE_SIZE] __initdata = ""; \
>> +                                                                       \
>> +               cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);   \
>> +               __cmdline_build(__c_dst, __c_tmp, (len));               \
>> +       } else {                                                        \
>> +               __cmdline_build(__c_dst, __c_src, (len));               \
>> +       }                                                               \
>> +} while (0)
>> +
>> +#endif /* _LINUX_CMDLINE_H */
>> --
>> 2.25.0
>>
