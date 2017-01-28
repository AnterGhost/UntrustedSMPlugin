#include <sourcemod>
#include <sdktools>
 
#define PLUGIN_NAME        "HvH | HvH"
#define PLUGIN_VERSION    "1.0.0"
 
public Plugin myinfo = {
    name        = PLUGIN_NAME,
    author        = "Radat.",
    description    = "Kills Player on Teleport or Invalid Angles.",
    version        = PLUGIN_VERSION,
    url            = "http://www.unknowncheats.me/forum/members/1646968.html"
}
 
public void OnPluginStart() {
    HookEvent("round_start", RoundStart, EventHookMode_PostNoCopy);
    CreateTimer(3.0, CheckUntrusted, _, TIMER_REPEAT);
}
 
public Action:HalfTime() {
    PrintToChatAll("\x01\x0B \x04[HvH] Hi");
}
 
public Action:RoundStart(Handle:event, const String:name[], bool:dontBroadcast) {
    for(int i = 1; i <= MaxClients; i++)
        if(IsValidEntity(i) && HasEntProp(i, Prop_Send, "m_vecOrigin") && IsClientConnected(i) && IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i))
            SetEntProp(i, Prop_Send, "m_iAccount", 16000);
            
    PrintToChatAll("\x01\x0B \x04[HvH] Everyone got 16k. HF.");
}
 
public Action CheckUntrusted(Handle timer) {
    for(int i = 1; i <= MaxClients; i++) {
        if(IsValidEntity(i) && HasEntProp(i, Prop_Send, "m_vecOrigin") && IsClientConnected(i) && IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i)) {
            char clientname[32];
            float pos[3];
            float view_pos[3];
            GetClientName(i, clientname, 32);
            GetEntPropVector(i, Prop_Send, "m_vecOrigin", pos);
            GetClientEyeAngles(i, view_pos);
            
            if (pos[0] == 0 && pos[1] == 0) {
                PrintToChatAll("\x01\x0B \x04[HvH] %s tried to use Teleport.", clientname);
                ForcePlayerSuicide(i);
            }
            
            if (view_pos[0] > 89 || view_pos[0] < -89) {
                PrintToChatAll("\x01\x0B \x04[HvH] %s uses invalid angles (X: %f, Y: %f, Z: %f)", clientname, view_pos[0], view_pos[1], view_pos[2]);
                ForcePlayerSuicide(i);
            }
            
            if (view_pos[1] > 180 || view_pos[1] < -180) {
                PrintToChatAll("\x01\x0B \x04[HvH] %s uses invalid angles (X: %f, Y: %f, Z: %f)", clientname, view_pos[0], view_pos[1], view_pos[2]);
                ForcePlayerSuicide(i);
            }
            
            if (view_pos[2] > 50 || view_pos[2] < -50) {
                PrintToChatAll("\x01\x0B \x04[HvH] %s uses invalid angles (X: %f, Y: %f, Z: %f)", clientname, view_pos[0], view_pos[1], view_pos[2]);
                ForcePlayerSuicide(i);
            }
        }
    }
}
