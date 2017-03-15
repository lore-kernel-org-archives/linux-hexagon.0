From: Till Smejkal <till.smejkal@googlemail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Date: Wed, 15 Mar 2017 16:18:43 -0700
Message-ID: <20170315231843.sgxzg6qj34anyirs@arch-dev>
References: <20170315220952.GA1435@intel.com>
Mime-Version: 1.0
Return-path: <owner-linux-aio@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cTOrRSbVEFPsTsy4MpkXreWhHtQFFmjceLO4PaXjU4=;
        b=OgRrkAJXzwQeK8ZiJfz7HWMHrxfvHW097fGc48HC9Fm8emwBC/XFnZ5QIb696If7kL
         sP6NPwFc8xrtyCizZH9s6ldPIo1TjLjOSHHEmB+PElWkbAgjjc1QnwGmiQ2RhvVqs0oI
         jftC/Xl/5AFFXjGU23nHVEAM9oUZhIs1NFtuNOZ1Vggx21Xzw6hUq+G40QgCs3Bo7cAe
         uZt888JQosd7uQTFDQxfRy4YY7T0duV0+wifNPS9nWtepVOyGntIwhQBOxmpeObbnRp4
         zMnQs6bn4W8VLcBlVflD2qcM84CNHtqXx+ujQgMaNpU6bzpXUojFFExKutwb0eodsgnN
         x0Ew==
Content-Disposition: inline
In-Reply-To: <20170315220952.GA1435@intel.com>
Sender: owner-linux-aio@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Till Smejkal <till.smejkal@googlemail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato>

On Wed, 15 Mar 2017, Luck, Tony wrote:
> On Wed, Mar 15, 2017 at 03:02:34PM -0700, Till Smejkal wrote:
> > I don't agree here. VAS segments are basically in-memory files that are handled by
> > the kernel directly without using a file system. Hence, if an application uses a VAS
> > segment to store data the same rules apply as if it uses a file. Everything that it
> > saves in the VAS segment might be accessible by other applications. An application
> > using VAS segments should be aware of this fact. In addition, the resources that are
> > represented by a VAS segment are not leaked. As I said, VAS segments are much like
> > files. Hence, if you don't want to use them any more, delete them. But as with files,
> > the kernel will not delete them for you (although something like this can be added).
> 
> So how do they differ from shmget(2), shmat(2), shmdt(2), shmctl(2)?
> 
> Apart from VAS having better names, instead of silly "key_t key" ones.

Unfortunately, I have to admit that the VAS segments don't differ from shm* a lot.
The implementation is differently, but the functionality that you can achieve with it
is very similar. I am sorry. We should have looked more closely at the whole
functionality that is provided by the shmem subsystem before working on VAS segments.

However, VAS segments are not the key part of this patch set. The more interesting
functionality in our opinion is the introduction of first class virtual address
spaces and what they can be used for. VAS segments were just another logical step for
us (from first class virtual address spaces to first class virtual address space
segments) but since their functionality can be achieved with various other already
existing features of the Linux kernel, I will probably drop them in future versions
of the patchset.

Thanks
Till

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
