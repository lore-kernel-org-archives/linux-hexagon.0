From: bcain@codeaurora.org
Subject: Re: [GIT PULL] hexagon changes for v5.13
Date: Thu, 06 May 2021 11:16:51 -0500
Message-ID: <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
 <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620317818; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZYIXNIJQToFO+yqUROpRHa/peGqV+Jnugb7ofs9QBf4=;
 b=xZYXyxGA5B9Pg+qLrSqqGRcEZIy0GKsSHcVB5czzV07iZ6tjC9cEkxgYvnYIOV82TmUZDS0S
 IuqDIUQiISk5z2PLRZKMqd8h1hL4OmQIoDIAO6HaG4YNPex6DUbz71NIqLxMUhOC2GtpoqHn
 0TmUPJRXpsUijG694PL0LI0pQH0=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, sidneym@codeaurora.org, clang-built-linux <clang-built-linux@googlegroups.com>

On 2021-05-06 11:03, Linus Torvalds wrote:
> On Wed, May 5, 2021 at 2:10 PM <bcain@codeaurora.org> wrote:
>> 
>> Please pull the following changes for Hexagon: they contain build 
>> fixes.
> 
> The pull looks fine, but I'm wondering what key you've signed this 
> with?
> 
> I find your key 175C464E541B6D47 in the kernel.org pgpkeys archive,
> but your tag was signed with RSA key 1A54AFB8E5646C32, which I don't
> find.
> 
> And the standard keyservers are - as usual - not very helpful.

I apologize -- in my initial account setup I'd done the key creation 
without a signing feature/capability.  So in order to sign the tag I 
realized I needed a new subkey for signing.  I tried broadcasting the 
new key but perhaps I did not send it correctly.  I'll try it again 
today.

http://keyserver.ubuntu.com/pks/lookup?search=bcain&fingerprint=on&op=index

^^^ this shows one that has 3d66aae474594824c88ce0f81a54afb8e5646c32 but 
I'm not quite sure if this is a good keyserver or not.

> I'd have loved to see a key I recognize, and I was hoping to also see
> that key signed by Richard Kuo. And maybe it is, but I can't find it..
> 
> Anyway, pulled, just hoping for some clarification,
> 
>                 Linus
