From: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] drivers/char: remove /dev/kmem for good
Date: Mon, 5 Apr 2021 10:16:35 -0700
Message-ID: <202104051013.F432CAC4@keescook>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-2-david@redhat.com>
Mime-Version: 1.0
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ai3CdCbkrXPSlQhahzdlfMoVkl12Ktt9EKKlkNpbqIk=;
        b=T5OZIJi1a+S0UmB8ju9dRtp9RWLpyoSfUudALSFJBsooFu63xRQSZft0M3qzy93k0r
         z7x2JAHldp19Jlo5384VoYUVNQ2yeLvjJ5z5R7QVmttinVeV9VjzoAdj8fejaeiR8lyF
         62143nJ12x8hml5vfS8LwEeOZj9TXLo/W5cC4=
Content-Disposition: inline
In-Reply-To: <20210319143452.25948-2-david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Oleksiy Avramchenko <oleksiy.avramchenko-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Minchan Kim <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, huang ying <huang.ying.caritas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Brian Cain <b>

On Fri, Mar 19, 2021 at 03:34:50PM +0100, David Hildenbrand wrote:
> Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
> memory ballooning, I started questioning the existance of /dev/kmem.
> 
> Comparing it with the /proc/kcore implementation, it does not seem to be
> able to deal with things like
> a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
>   -> kern_addr_valid(). virt_addr_valid() is not sufficient.
> b) Special cases like gart aperture memory that is not to be touched
>   -> mem_pfn_is_ram()
> Unless I am missing something, it's at least broken in some cases and might
> fault/crash the machine.
> 
> Looks like its existance has been questioned before in 2005 and 2010
> [1], after ~11 additional years, it might make sense to revive the
> discussion.
> 
> CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
> mistake?). All distributions I looked at disable it.
> 
> 1) /dev/kmem was popular for rootkits [2] before it got disabled
>    basically everywhere. Ubuntu documents [3] "There is no modern user of
>    /dev/kmem any more beyond attackers using it to load kernel rootkits.".
>    RHEL documents in a BZ [5] "it served no practical purpose other than to
>    serve as a potential security problem or to enable binary module drivers
>    to access structures/functions they shouldn't be touching"
> 
> 2) /proc/kcore is a decent interface to have a controlled way to read
>    kernel memory for debugging puposes. (will need some extensions to
>    deal with memory offlining/unplug, memory ballooning, and poisoned
>    pages, though)
> 
> 3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
>    better fit, especially, to write random memory; harder to shoot
>    yourself into the foot.
> 
> 4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
>    to be incompatible with 64bit [1]. For educational purposes,
>    /proc/kcore might be used to monitor value updates -- or older
>    kernels can be used.
> 
> 5) It's broken on arm64, and therefore, completely disabled there.
> 
> Looks like it's essentially unused and has been replaced by better
> suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
> just remove it.
> 
> [1] https://lwn.net/Articles/147901/
> [2] https://www.linuxjournal.com/article/10505
> [3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
> [4] https://sourceforge.net/projects/kme/
> [5] https://bugzilla.redhat.com/show_bug.cgi?id=154796
> 
> [...]
> Cc: Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: David Hildenbrand <david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Yes please! As James Troup pointed out already, this was turned off in
Ubuntu in 2008. I don't remember a single complaint from anyone who
wasn't a rootkit author. ;)

Acked-by: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

-- 
Kees Cook
