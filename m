From: bcain@codeaurora.org
Subject: Re: [GIT PULL] hexagon changes for v5.13
Date: Thu, 06 May 2021 11:17:56 -0500
Message-ID: <43df6483efd78b46f53e865bd75d75a4@codeaurora.org>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
 <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
 <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620317877; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ayfl19XdqX6m/TbOtD8KiL0xKcwzcp5FHJ6ltxor5Ow=;
 b=wl9fbbgJEf7xP1tF1jic2QuQYYN7vxYdhamEW/sySgqDB+KWP8vHaaKmvJAdaryE97tDCXUM
 zrCXeldTiMba9A0lfRYix5Y2n3d8+VFKiQroRw2Ex8QxTbROoRJlBCOF3CPstWbJ27UwOcvi
 l6BLdRBFExDIofzhRdXD617fs20=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, sidneym@codeaurora.org, clang-built-linux <clang-built-linux@googlegroups.com>

On 2021-05-06 11:16, bcain@codeaurora.org wrote:
> On 2021-05-06 11:03, Linus Torvalds wrote:
>> On Wed, May 5, 2021 at 2:10 PM <bcain@codeaurora.org> wrote:
>>> 
>>> Please pull the following changes for Hexagon: they contain build 
>>> fixes.
>> 
>> The pull looks fine, but I'm wondering what key you've signed this 
>> with?
>> 
>> I find your key 175C464E541B6D47 in the kernel.org pgpkeys archive,
>> but your tag was signed with RSA key 1A54AFB8E5646C32, which I don't
>> find.
>> 
>> And the standard keyservers are - as usual - not very helpful.
> 
> I apologize -- in my initial account setup I'd done the key creation
> without a signing feature/capability.  So in order to sign the tag I
> realized I needed a new subkey for signing.  I tried broadcasting the
> new key but perhaps I did not send it correctly.  I'll try it again
> today.
> 
> http://keyserver.ubuntu.com/pks/lookup?search=bcain&fingerprint=on&op=index
> 
> ^^^ this shows one that has 3d66aae474594824c88ce0f81a54afb8e5646c32
> but I'm not quite sure if this is a good keyserver or not.

Oh, but the new signing subkey has not been signed by anyone yet.  I 
will see about that.

-Brian
