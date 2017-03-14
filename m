From: Till Smejkal <till.smejkal@googlemail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Date: Mon, 13 Mar 2017 19:07:09 -0700
Message-ID: <20170314020709.vxeglus54k76i7rn@arch-dev>
References: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8lAifVLftxCDt05mTDrVYKXmHSB13ZRC+ceVMa4DhVA=;
        b=vdw3uQnAGgyp/v1sEUo4i9vPKo4qUZlDjF/dNgVLLgGC39WaioLuJsrtQ35c1AwZ9v
         gJ8ROXEuZ+776yOIwaumneHg+VWQc4S8Zmk6+SHOtIeLqvjcq0WzmedmsvG2/ojhlCh8
         7sleOFNZWAjAc2SG8lV9BJvCVAzOfCXINk4WwZEeLoSEM0vC/TeaXMa7PDS9MwQM20Ub
         dFcJi1mYbHXbkKe1wIopx2KfE/VosdPXN1/5OetHGLk102zdn/aG230SVsGm277/iB+8
         bn4yTol0FHokC58Yu+rK+O2hj9jPiMlm2icpc4BIbNcSDDfSnjVMcYZOq5JPH2nDvP6T
         0jZA==
Content-Disposition: inline
In-Reply-To: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Andy Lutomirski <luto@kernel.org>
Cc: Till Smejkal <till.smejkal@googlemail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalia>

On Mon, 13 Mar 2017, Andy Lutomirski wrote:
> On Mon, Mar 13, 2017 at 3:14 PM, Till Smejkal
> <till.smejkal@googlemail.com> wrote:
> > This patchset extends the kernel memory management subsystem with a new
> > type of address spaces (called VAS) which can be created and destroyed
> > independently of processes by a user in the system. During its lifetime
> > such a VAS can be attached to processes by the user which allows a proc=
ess
> > to have multiple address spaces and thereby multiple, potentially
> > different, views on the system's main memory. During its execution the
> > threads belonging to the process are able to switch freely between the
> > different attached VAS and the process' original AS enabling them to
> > utilize the different available views on the memory.
>=20
> Sounds like the old SKAS feature for UML.

I haven't heard of this feature before, but after shortly looking at the de=
scription
on the UML website it actually has some similarities with what I am proposi=
ng. But as
far as I can see this was not merged into the mainline kernel, was it? In a=
ddition, I
think that first class virtual address spaces goes even one step further by=
 allowing
AS to live independently of processes.

> > In addition to the concept of first class virtual address spaces, this
> > patchset introduces yet another feature called VAS segments. VAS segmen=
ts
> > are memory regions which have a fixed size and position in the virtual
> > address space and can be shared between multiple first class virtual
> > address spaces. Such shareable memory regions are especially useful for
> > in-memory pointer-based data structures or other pure in-memory data.
>=20
> This sounds rather complicated.  Getting TLB flushing right seems
> tricky.  Why not just map the same thing into multiple mms?

This is exactly what happens at the end. The memory region that is describe=
d by the
VAS segment will be mapped in the ASes that use the segment.

> >
> >             |     VAS     |  processes  |
> >     -------------------------------------
> >     switch  |       468ns |      1944ns |
>=20
> The solution here is IMO to fix the scheduler.

IMHO it will be very difficult for the scheduler code to reach the same swi=
tching
time as the pure VAS switch because switching between VAS does not involve =
saving any
registers or FPU state and does not require selecting the next runnable tas=
k. VAS
switch is basically a system call that just changes the AS of the current t=
hread
which makes it a very lightweight operation.

> Also, FWIW, I have patches (that need a little work) that will make
> switch_mm() waaaay faster on x86.

These patches will also improve the speed of the VAS switch operation. We a=
re also
using the switch_mm function in the background to perform the actual hardwa=
re switch
between the two ASes. The main reason why the VAS switch is faster than the=
 task
switch is that it just has to do fewer things.

> > At the current state of the development, first class virtual address sp=
aces
> > have one limitation, that we haven't been able to solve so far. The fea=
ture
> > allows, that different threads of the same process can execute in diffe=
rent
> > AS at the same time. This is possible, because the VAS-switch operation
> > only changes the active mm_struct for the task_struct of the calling
> > thread. However, when a thread switches into a first class virtual addr=
ess
> > space, some parts of its original AS are duplicated into the new one to
> > allow the thread to continue its execution at its current state.
>=20
> Ick.  Please don't do this.  Can we please keep an mm as just an mm
> and not make it look magically different depending on which process
> maps it?  If you need a trampoline (which you do, of course), just
> write a trampoline in regular user code and map it manually.

Did I understand you correctly that you are proposing that the switching th=
read
should make sure by itself that its code, stack, =E2=80=A6 memory regions a=
re properly setup
in the new AS before/after switching into it? I think, this would make usin=
g first
class virtual address spaces much more difficult for user applications to t=
he extend
that I am not even sure if they can be used at all. At the moment, switchin=
g into a
VAS is a very simple operation for an application because the kernel will j=
ust simply
do the right thing.

Till

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
