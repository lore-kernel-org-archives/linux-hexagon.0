From: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Date: Tue, 25 Oct 2016 08:47:48 +0800
Message-ID: <CAFiDJ59PdOiqiF8wFVFrkB4k0B6S5cTGVQPUpdjZ=83iv7GQag@mail.gmail.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com> <20161024090931.GR7370@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HOWgsYKgLqr/jim7ASDx4uwm8eeYQngM65rjpnt6rHY=;
        b=AoBrwCVbxrKmeeh9DxJloMy3unOdP6CBN+nPmp88XTINf/RFGJuN9YWRtsATG/Xj2d
         3NlszmM1sSficvuI2zzcxjbOvHIPdRpi0IHaEePPFq8RKe2nXzAFgo4LzC0w5KrrE1z7
         yjavukuBncjZ4H5mPRLydpCw9/Vc1BKwZ69OzNXD82ta4rw7YmsZVEczv8YT0+e8ehUz
         HOW+ws7VzUtQPomDFfFZPRMePB90zqz3XNmgxG6+0mUPXvnLSGl0CpflEwGLwo/n7owU
         CLHUflAiJhy1A4w3xCDMZXQxDTQJdrPjLXdducp7vm+u1X8Go+REH9SYT3x4XJT93Sha
         UDQg==
In-Reply-To: <20161024090931.GR7370-4bYivNCBEGTR3KXKvIWQxtm+Uo4AYnCiHZ5vskTnxNA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TaqPxH82wqD4g@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Chen Liqin <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Metcalf <cmetcalf-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Andrew Pinski <Andrew.Pinski-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On Mon, Oct 24, 2016 at 5:09 PM, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, Oct 22, 2016 at 03:14:04PM +0300, Yury Norov wrote:
>> The newer prlimit64 syscall provides all the functionality provided by
>> the getrlimit and setrlimit syscalls and adds the pid of target process,
>> so future architectures won't need to include getrlimit and setrlimit.
>>
>> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
>> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
>> unistd.h prior to including asm-generic/unistd.h, and adjust all
>> architectures using the generic syscall list to define it so that no
>> in-tree architectures are affected.
>>
>> Cc: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
>> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>
>> Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
>> Cc: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> Cc: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
>> Cc: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
>> Cc: Chen Liqin <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Chris Metcalf <cmetcalf-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
>> Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Andrew Pinski <Andrew.Pinski-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Cc: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Cc: linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org
>> Cc: uclinux-h8-devel-5NWGOfrQmneRv+LV9MX5uooqe+aC9MnS@public.gmane.org
>> Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
>> Cc: linux-arch-u79uwXL29TaqPxH82wqD4g@public.gmane.org
>> Signed-off-by: Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> ---
>>  arch/arc/include/uapi/asm/unistd.h       | 1 +
>>  arch/arm64/include/uapi/asm/unistd.h     | 1 +
>>  arch/c6x/include/uapi/asm/unistd.h       | 1 +
>>  arch/h8300/include/uapi/asm/unistd.h     | 1 +
>>  arch/hexagon/include/uapi/asm/unistd.h   | 1 +
>>  arch/metag/include/uapi/asm/unistd.h     | 1 +
>
> Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> [metag]
>
> Cheers
> James
>
>>  arch/nios2/include/uapi/asm/unistd.h     | 1 +
Acked-by: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org> [nios2]


>>  arch/openrisc/include/uapi/asm/unistd.h  | 1 +
>>  arch/score/include/uapi/asm/unistd.h     | 1 +
>>  arch/tile/include/uapi/asm/unistd.h      | 1 +
>>  arch/unicore32/include/uapi/asm/unistd.h | 1 +
>>  include/uapi/asm-generic/unistd.h        | 5 +++++
>>  12 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
>> index 41fa2ec..928546d 100644
>> --- a/arch/arc/include/uapi/asm/unistd.h
>> +++ b/arch/arc/include/uapi/asm/unistd.h
>> @@ -16,6 +16,7 @@
>>  #define _UAPI_ASM_ARC_UNISTD_H
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #define __ARCH_WANT_SYS_EXECVE
>>  #define __ARCH_WANT_SYS_CLONE
>>  #define __ARCH_WANT_SYS_VFORK
>> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
>> index 043d17a..48355a6 100644
>> --- a/arch/arm64/include/uapi/asm/unistd.h
>> +++ b/arch/arm64/include/uapi/asm/unistd.h
>> @@ -15,5 +15,6 @@
>>   */
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>
>>  #include <asm-generic/unistd.h>
>> diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
>> index 12d73d9..f676231 100644
>> --- a/arch/c6x/include/uapi/asm/unistd.h
>> +++ b/arch/c6x/include/uapi/asm/unistd.h
>> @@ -15,6 +15,7 @@
>>   */
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #define __ARCH_WANT_SYS_CLONE
>>
>>  /* Use the standard ABI for syscalls. */
>> diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
>> index 7dd20ef..2f98394 100644
>> --- a/arch/h8300/include/uapi/asm/unistd.h
>> +++ b/arch/h8300/include/uapi/asm/unistd.h
>> @@ -1,5 +1,6 @@
>>  #define __ARCH_NOMMU
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>
>>  #include <asm-generic/unistd.h>
>> diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
>> index 2151760..52d585c 100644
>> --- a/arch/hexagon/include/uapi/asm/unistd.h
>> +++ b/arch/hexagon/include/uapi/asm/unistd.h
>> @@ -28,6 +28,7 @@
>>
>>  #define sys_mmap2 sys_mmap_pgoff
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #define __ARCH_WANT_SYS_EXECVE
>>  #define __ARCH_WANT_SYS_CLONE
>>  #define __ARCH_WANT_SYS_VFORK
>> diff --git a/arch/metag/include/uapi/asm/unistd.h b/arch/metag/include/uapi/asm/unistd.h
>> index 459b6ec..16b5cb3 100644
>> --- a/arch/metag/include/uapi/asm/unistd.h
>> +++ b/arch/metag/include/uapi/asm/unistd.h
>> @@ -8,6 +8,7 @@
>>   */
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>
>>  /* Use the standard ABI for syscalls. */
>>  #include <asm-generic/unistd.h>
>> diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
>> index 51a32c7..b0dda4d 100644
>> --- a/arch/nios2/include/uapi/asm/unistd.h
>> +++ b/arch/nios2/include/uapi/asm/unistd.h
>> @@ -18,6 +18,7 @@
>>   #define sys_mmap2 sys_mmap_pgoff
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>
>>  /* Use the standard ABI for syscalls */
>>  #include <asm-generic/unistd.h>
>> diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
>> index 471905b..6812d81 100644
>> --- a/arch/openrisc/include/uapi/asm/unistd.h
>> +++ b/arch/openrisc/include/uapi/asm/unistd.h
>> @@ -21,6 +21,7 @@
>>  #define sys_mmap2 sys_mmap_pgoff
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #define __ARCH_WANT_SYS_FORK
>>  #define __ARCH_WANT_SYS_CLONE
>>
>> diff --git a/arch/score/include/uapi/asm/unistd.h b/arch/score/include/uapi/asm/unistd.h
>> index d4008c3..7ad1bdc 100644
>> --- a/arch/score/include/uapi/asm/unistd.h
>> +++ b/arch/score/include/uapi/asm/unistd.h
>> @@ -1,6 +1,7 @@
>>  #define __ARCH_HAVE_MMU
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #define __ARCH_WANT_SYSCALL_NO_AT
>>  #define __ARCH_WANT_SYSCALL_NO_FLAGS
>>  #define __ARCH_WANT_SYSCALL_OFF_T
>> diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
>> index 24e9187..cf0505f 100644
>> --- a/arch/tile/include/uapi/asm/unistd.h
>> +++ b/arch/tile/include/uapi/asm/unistd.h
>> @@ -13,6 +13,7 @@
>>   */
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>  #if !defined(__LP64__) || defined(__SYSCALL_COMPAT)
>>  /* Use the flavor of this syscall that matches the 32-bit API better. */
>>  #define __ARCH_WANT_SYNC_FILE_RANGE2
>> diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
>> index 1f63c47..ef25aec 100644
>> --- a/arch/unicore32/include/uapi/asm/unistd.h
>> +++ b/arch/unicore32/include/uapi/asm/unistd.h
>> @@ -11,6 +11,7 @@
>>   */
>>
>>  #define __ARCH_WANT_RENAMEAT
>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>
>>  /* Use the standard ABI for syscalls. */
>>  #include <asm-generic/unistd.h>
>> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
>> index 9b1462e..bbaeac0 100644
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -465,10 +465,15 @@ __SYSCALL(__NR_uname, sys_newuname)
>>  __SYSCALL(__NR_sethostname, sys_sethostname)
>>  #define __NR_setdomainname 162
>>  __SYSCALL(__NR_setdomainname, sys_setdomainname)
>> +
>> +#ifdef __ARCH_WANT_SET_GET_RLIMIT
>> +/* getrlimit and setrlimit are superseded with prlimit64 */
>>  #define __NR_getrlimit 163
>>  __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
>>  #define __NR_setrlimit 164
>>  __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
>> +#endif
>> +
>>  #define __NR_getrusage 165
>>  __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
>>  #define __NR_umask 166
>> --
>> 2.7.4
>>
