From: Till Smejkal <till.smejkal@googlemail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Date: Wed, 15 Mar 2017 12:44:47 -0700
Message-ID: <20170315194447.scsf3fiwvf7z5gzc@arch-dev>
References: <CALCETrX5gv+zdhOYro4-u3wGWjVCab28DFHPSm5=BVG_hKxy3A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-aio@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zq1KQ1qx63E3h1lESbp46QzaSWUSeZO/pkzhE++D5Lw=;
        b=P/AccalLZqi5XqN6dGtPeBefPYZ9i0ymDTF6qo1YIXX5PQyHG2BYDK7Su6QB7qe+6W
         qqy3jcOQnTqHjJPreqI7MjSoNgbq+iFioLkGPq9SbjjR+dgRSPZIOYEQFtqBKHcp1i0M
         fzsXDFuwLphAXHvzJkDgPkm7EU+Bpvbt2O+Y1VgcvWrkNXIk8VHbk0t7Lovz8/L/ze4W
         bkVeYi8Dj/8ImXCRyMvBLM3B+QBvTKOn5fYPLcfm4kqEli9EUl5JYe/ZyuLPe5fcks6r
         I1t5KlKzPXO5IwTvPRp/DAEUSZ6OXQ5mWqt93OVdN7Tdb1j2iHDRIe4X97TrqW8kBwY6
         N7qg==
Content-Disposition: inline
In-Reply-To: <CALCETrX5gv+zdhOYro4-u3wGWjVCab28DFHPSm5=BVG_hKxy3A@mail.gmail.com>
Sender: owner-linux-aio@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Till Smejkal <till.smejkal@googlemail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.>

On Wed, 15 Mar 2017, Andy Lutomirski wrote:
> > One advantage of VAS segments is that they can be globally queried by u=
ser programs
> > which means that VAS segments can be shared by applications that not ne=
cessarily have
> > to be related. If I am not mistaken, MAP_SHARED of pure in memory data =
will only work
> > if the tasks that share the memory region are related (aka. have a comm=
on parent that
> > initialized the shared mapping). Otherwise, the shared mapping have to =
be backed by a
> > file.
>=20
> What's wrong with memfd_create()?
>=20
> > VAS segments on the other side allow sharing of pure in memory data by
> > arbitrary related tasks without the need of a file. This becomes especi=
ally
> > interesting if one combines VAS segments with non-volatile memory since=
 one can keep
> > data structures in the NVM and still be able to share them between mult=
iple tasks.
>=20
> What's wrong with regular mmap?

I never wanted to say that there is something wrong with regular mmap. We j=
ust
figured that with VAS segments you could remove the need to mmap your share=
d data but
instead can keep everything purely in memory.

Unfortunately, I am not at full speed with memfds. Is my understanding corr=
ect that
if the last user of such a file descriptor closes it, the corresponding mem=
ory is
freed? Accordingly, memfd cannot be used to keep data in memory while no pr=
ogram is
currently using it, can it? To be able to do this you need again some repre=
sentation
of the data in a file? Yes, you can use a tmpfs to keep the file content in=
 memory as
well, or some DAX filesystem to keep the file content in NVM, but this alwa=
ys
requires that such filesystems are mounted in the system that the applicati=
on is
currently running on. VAS segments on the other side would provide a functi=
onality to
achieve the same without the need of any mounted filesystem. However, I agr=
ee, that
this is just a small advantage compared to what can already be achieved wit=
h the
existing functionality provided by the Linux kernel. I probably need to rev=
isit the
whole idea of first class virtual address space segments before continuing =
with this
pacthset. Thank you very much for the great feedback.

> >> >> Ick.  Please don't do this.  Can we please keep an mm as just an mm
> >> >> and not make it look magically different depending on which process
> >> >> maps it?  If you need a trampoline (which you do, of course), just
> >> >> write a trampoline in regular user code and map it manually.
> >> >
> >> > Did I understand you correctly that you are proposing that the switc=
hing thread
> >> > should make sure by itself that its code, stack, =E2=80=A6 memory re=
gions are properly setup
> >> > in the new AS before/after switching into it? I think, this would ma=
ke using first
> >> > class virtual address spaces much more difficult for user applicatio=
ns to the extend
> >> > that I am not even sure if they can be used at all. At the moment, s=
witching into a
> >> > VAS is a very simple operation for an application because the kernel=
 will just simply
> >> > do the right thing.
> >>
> >> Yes.  I think that having the same mm_struct look different from
> >> different tasks is problematic.  Getting it right in the arch code is
> >> going to be nasty.  The heuristics of what to share are also tough --
> >> why would text + data + stack or whatever you're doing be adequate?
> >> What if you're in a thread?  What if two tasks have their stacks in
> >> the same place?
> >
> > The different ASes that a task now can have when it uses first class vi=
rtual address
> > spaces are not realized in the kernel by using only one mm_struct per t=
ask that just
> > looks differently but by using multiple mm_structs - one for each AS th=
at the task
> > can execute in. When a task attaches a first class virtual address spac=
e to itself to
> > be able to use another AS, the kernel adds a temporary mm_struct to thi=
s task that
> > contains the mappings of the first class virtual address space and the =
one shared
> > with the task's original AS. If a thread now wants to switch into this =
attached first
> > class virtual address space the kernel only changes the 'mm' and 'activ=
e_mm' pointers
> > in the task_struct of the thread to the temporary mm_struct and perform=
s the
> > corresponding mm_switch operation. The original mm_struct of the thread=
 will not be
> > changed.
> >
> > Accordingly, I do not magically make mm_structs look differently depend=
ing on the
> > task that uses it, but create temporary mm_structs that only contain ma=
ppings to the
> > same memory regions.
>=20
> This sounds complicated and fragile.  What happens if a heuristically
> shared region coincides with a region in the "first class address
> space" being selected?

If such a conflict happens, the task cannot use the first class address spa=
ce and the
corresponding system call will return an error. However, with the current a=
vailable
virtual address space size that programs can use, such conflicts are probab=
ly rare. I
could also image some additional functionality that allows a user to mark p=
arts of
its AS to not to be shared/to be shared when switching into a VAS. With this
functionality in place, there would be no need for a heuristic in the kerne=
l but the
user decides what to share. The kernel would by default only share code, da=
ta, and
stack and the application/libraries have to mark all the other memory regio=
ns as
shared if they need to be also available in the VAS.

> I think the right solution is "you're a user program playing virtual
> address games -- make sure you do it right".

Hm, in general I agree, that the easier and more robust solution from the k=
ernel
perspective is to let the user do the AS setup and only provide the functio=
nality to
create new empty ASes. Though, I think that such an interface would be much=
 more
difficult to use than my current design. Letting the user program setup the=
 AS has
also another implication that I currently don't have. Since I share the cod=
e and
stack regions between all ASes that are available to a process, I don't nee=
d to
save/restore stack pointers or instruction pointers when threads switch bet=
ween ASes.
However, when the user will setup the AS, the kernel cannot be sure that th=
e code and
stack will be mapped at the same virtual address and hence has to save and =
restore
these registers (and also potentially others since we can now basically jum=
p between
different execution contexts).

When we first designed first class virtual address spaces, we had one speci=
al
use-case in mind, namely that one application wants to use different data s=
ets that
it does not want/can keep in the same AS. Hence, sharing code and stack bet=
ween the
different ASes that the application uses was a logic step for us because th=
e code
memory region for example has to be available at all AS anyways since all o=
f them
execute the same application. Sharing the stack memory region enabled the a=
pplication
to keep volatile information that might be needed in the new AS on the stac=
k which
allows easy information flow between the different ASes.=20

For this patch, I extended the initial sharing of stack and code memory reg=
ions to
all memory regions that are available in the tasks original AS to also allow
dynamically linked applications and multi-threaded applications to flawless=
ly use
first class virtual address spaces.

To put it in a nutshell, we envisioned first class virtual address spaces t=
o be
rather used as shareable/reusable data containers which made sharing variou=
s memory
regions that are crucial for the execution of the application a feasible
implementation decision.

Thank you all very much for the feedback. I really appreciate it.

Till

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=3Dmailto:"aart@kvack.org">aart@kvack.org</a>
